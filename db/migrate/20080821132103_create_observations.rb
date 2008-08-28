class CreateObservations < ActiveRecord::Migration
  def self.up
    create_table :observations do |t|
      t.string :value_type
      t.string :identifier
      t.string :identifier_text
      t.string :identifier_code_system
      t.string :observation_value
      t.string :units
      t.string :reference_range
      t.string :abnormal_flags
      t.belongs_to :patient
    end
  end

  def self.down
    drop_table :observations
  end
end
