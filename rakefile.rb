require "active_record"

desc "list rake tasks"
task :default do
  STDOUT.write(`rake -T`)
end

namespace :db do
  db_config = YAML::load(File.open("config/database.yml"))

  desc "Create the database"
  task :create do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Base.connection

    puts "Database created"
  end

  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::MigrationContext.new(db_config["migrate"]).migrate
    Rake::Task["db:schema"].invoke

    puts "Database migrated"
  end

  desc "Migrate down"
  task :down do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::MigrationContext.new(db_config["migrate"]).down

    puts "Database migration was down"
  end

  desc "Migration up"
  task :up do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::MigrationContext.new(db_config["migrate"]).up

    puts "Database migration was down"
  end

  desc "Drop the database"
  task :drop do
    `rm #{db_config["database"]}`

    puts "Database deleted"
  end

  desc "Reset the database"
  task :reset => [:drop, :create, :migrate]

  desc "Create a db/schema.rb file that is portable against any DB supported by AR"
  task :schema do
    ActiveRecord::Base.establish_connection(db_config)
    require "active_record/schema_dumper"
    filename = "db/schema.rb"
    File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end

    puts "Database schema was dumped to db/schema.rb"
  end
end

namespace :g do
  desc "Generate migration"
  task :migration do
    name = ARGV[1] || raise("Specify name: rake g:migration")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, "w") do |file|
      file.write <<-EOF
class #{migration_class} < ActiveRecord::Migration[5.2]
  def self.up
  end

  def self.down
  end
end
      EOF
    end

    puts "Migration db/migrate/#{timestamp}_#{name}.rb created"
    exit true
  end
end
