class AddNotesColumnToChecks < ActiveRecord::Migration
  def change
    add_column :checks, :note, :text
  end
end
