class CleanUpObservations < ActiveRecord::Migration
  def self.up
    drop_table :code_systems
    remove_column :observations, :identifier_code_system
    remove_column :observations, :code_system_id
  end

  def self.down
    add_column :observations, :code_system_id, :integer
    add_column :observations, :identifier_code_system, :string
    create_table "code_systems", :force => true do |t|
      t.string "name"
      t.string "code"
    end
  end
end
