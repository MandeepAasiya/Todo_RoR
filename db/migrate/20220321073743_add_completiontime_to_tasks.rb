class AddCompletiontimeToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :completiontime, :datetime
  end
end
