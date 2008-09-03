class CreateObservationToLoincRelationship < ActiveRecord::Migration

  def self.up
    remove_column "observations", "identifier"
    remove_column "observations", "identifier_text"
    add_column "observations", "loinc_lab_code_id", :integer
  end

  def self.down
    add_column "observations", "identifier", :string
    add_column "observations", "identifier_text", :string
    remove_column "observations", "loinc_lab_code_id"
  end

end
