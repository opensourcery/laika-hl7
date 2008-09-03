class CreateObservationToCodeSystemRelationship < ActiveRecord::Migration

  def self.up
    add_column "observations", "code_system_id", :integer
  end

  def self.down
    remove_column "observations", "code_system_id"
  end

end
