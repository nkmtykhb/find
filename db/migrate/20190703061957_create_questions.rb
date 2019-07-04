class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :student_id
      t.text :content
      t.string :image_name

      t.timestamps
    end
  end
end
