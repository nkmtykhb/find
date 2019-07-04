class ChangeDataMessageToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :students, :message, :text
    change_column :teachers, :message, :text
  end
end
