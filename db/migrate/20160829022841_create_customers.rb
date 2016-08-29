class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :code
      t.string :name_abrev
      t.string :name
      t.string :reg_addr
      t.string :contact_addr
      t.string :declare_type
      t.string :contact
      t.string :phone
      t.string :cellphone
      t.string :fax
      t.string :email
      t.string :fee

      t.integer :officer_id
      t.integer :leader_id
      t.integer :manager_id

      t.string :status
      t.date :start_date
      t.text :note_1
      t.text :note_2
      
      t.timestamps null: false
    end
  end
end
