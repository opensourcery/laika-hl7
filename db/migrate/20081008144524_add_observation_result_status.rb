class AddObservationResultStatus < ActiveRecord::Migration
  def self.up
    add_column :observations, :result_status, :string, :length => 1
  end

  def self.down
    remove_column :observations, :result_status
  end
end
