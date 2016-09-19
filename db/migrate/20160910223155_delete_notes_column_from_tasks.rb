class DeleteNotesColumnFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :note
  end
end
