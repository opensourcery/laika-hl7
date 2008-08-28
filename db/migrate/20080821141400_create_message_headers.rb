class CreateMessageHeaders < ActiveRecord::Migration
  def self.up
    create_table :message_headers do |t|
      t.string :sending_application
      t.string :sending_facility
      t.string :receiving_application
      t.string :receiving_facility
      t.date   :message_date
      t.string :message_type
      t.string :message_control_identifier
      t.belongs_to :patient
    end
  end

  def self.down
    drop_table :message_headers
  end
end
