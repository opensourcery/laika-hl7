class CreateValidationErrors < ActiveRecord::Migration
  def self.up
    create_table :validation_errors do |t|
      t.string :message
      t.string :location
      t.belongs_to :received_message
      t.timestamps
    end
  end

  def self.down
    drop_table :validation_errors
  end
end
