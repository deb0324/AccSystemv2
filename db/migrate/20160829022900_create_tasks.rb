class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :year
      t.integer :customer_id
      t.integer :vat_jan
      t.integer :vat_mar
      t.integer :vat_may
      t.integer :vat_jul
      t.integer :vat_sept
      t.integer :vat_nov
      t.integer :voucher
      t.integer :income_tax
      
      t.timestamps null: false
    end
  end
end
