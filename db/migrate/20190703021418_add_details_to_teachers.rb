class AddDetailsToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :laboratory, :string
    add_column :teachers, :equipment, :string
    add_column :teachers, :url, :string
    add_column :teachers, :message, :string
  end
end
