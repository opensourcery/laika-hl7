class CleanUpObservations < ActiveRecord::Migration
  def self.up
    drop_table :code_systems
    remove_column :observations, :identifier_code_system
  end

  def self.down
    add_column :observations, :identifier_code_system, :string
    create_table "code_systems", :force => true do |t|
      t.string "name"
      t.string "code"
    end
  end
end
