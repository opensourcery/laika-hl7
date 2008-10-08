class AddProcessingId < ActiveRecord::Migration
  def self.up
    add_column :message_headers, :processing_id_field, :string, :length => 1
  end

  def self.down
    remove_column :message_headers, :processing_id_field
  end
end
