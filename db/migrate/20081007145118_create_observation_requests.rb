class CreateObservationRequests < ActiveRecord::Migration
  def self.up
    create_table :observation_requests do |t|
      t.string :ordering_provider
      t.belongs_to :patient
      t.belongs_to :loinc_lab_code
    end
  end

  def self.down
    drop_table :observation_requests
  end
end
