class AddContentToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :url, :string
    add_column :students, :laboratory, :string
    add_column :students, :message, :string
  end
end
