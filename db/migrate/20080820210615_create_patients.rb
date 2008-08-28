class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string :identifier
      t.string :family_name
      t.string :given_name
      t.date :date_of_birth
      t.string :administrative_sex
      t.string :street_address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :home_phone
      t.string :business_phone

      t.timestamps
    end
  end

  def self.down
    drop_table :patients
  end
end
