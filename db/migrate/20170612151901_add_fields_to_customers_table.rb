class AddFieldsToCustomersTable < ActiveRecord::Migration
  def change
    rename_column :customers, :phone, :phone_1
    add_column :customers, :phone_2, :string
    add_column :customers, :phone_3, :string

    rename_column :customers, :contact, :contact_1
    add_column :customers, :contact_2, :string
    add_column :customers, :contact_3, :string

    rename_column :customers, :cellphone, :cellphone_1
    add_column :customers, :cellphone_2, :string
    add_column :customers, :cellphone_3, :string

    add_column :customers, :note_3, :text
    add_column :customers, :note_4, :text
    add_column :customers, :note_5, :text
    add_column :customers, :note_6, :text

    rename_column :customers, :fee, :monthly_fee
    add_column :customers, :extra_fee, :integer
    add_column :customers, :tax_fee, :integer
    add_column :customers, :audit_fee, :integer
  end
end
