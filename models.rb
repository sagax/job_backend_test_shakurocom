require "active_record"
require "yaml"

db_config = YAML::load(File.open("config/database.yml"))
ActiveRecord::Base.establish_connection(db_config)
ActiveRecord::Base.connection

class Abstract < ActiveRecord::Base
  self.abstract_class = true

  def as_json(options=nil)
    if options.nil?
      options = {}
      options[:except] ||= [
        :created_at,
        :updated_at
      ]

      options[:include] ||= [
      ]
      super
    else
      options = options
      super
    end
  end
end

Dir["./models/*.rb"].each {|f| require f}
