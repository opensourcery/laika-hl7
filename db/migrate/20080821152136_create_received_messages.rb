class CreateReceivedMessages < ActiveRecord::Migration
  def self.up
    create_table :received_messages do |t|
      t.text :message_contents

      t.timestamps
    end
  end

  def self.down
    drop_table :received_messages
  end
end
