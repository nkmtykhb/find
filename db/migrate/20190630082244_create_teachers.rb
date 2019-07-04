class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :email
      t.string :field
      t.string :school
      t.string :image_name
      t.string :password

      t.timestamps
    end
  end
end
