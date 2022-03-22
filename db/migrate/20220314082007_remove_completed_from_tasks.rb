class RemoveCompletedFromTasks < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :completed, :boolean
  end

  def change
    change_column :tasks, :priority, :integer
  end
end
