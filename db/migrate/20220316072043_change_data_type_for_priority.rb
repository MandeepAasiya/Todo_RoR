class ChangeDataTypeForPriority < ActiveRecord::Migration[7.0]
  def change
    change_column (:tasks, :priority, :integer)
  end
end
