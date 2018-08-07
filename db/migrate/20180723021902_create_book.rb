class CreateBook < ActiveRecord::Migration[5.2]
  def self.up
    create_table :books do |t|
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
