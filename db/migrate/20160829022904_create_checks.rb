class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.boolean :recieved
      t.datetime :recieved_time
      t.boolean :primary
      t.datetime :primary_time
      t.boolean :secondary
      t.datetime :secondary_time
      t.boolean :accountant
      t.datetime :accountant_time
      t.boolean :upload
      t.datetime :upload_time
      
      t.timestamps null: false
    end
  end
end
