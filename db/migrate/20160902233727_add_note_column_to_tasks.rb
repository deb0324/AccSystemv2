class AddNoteColumnToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :note, :text
  end
end
