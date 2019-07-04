class Student < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true,uniqueness: true}
  validates :password, {presence: true,length: {minimum: 8}}
  def self.sc_name(search)
      if search
        Student.where(['name LIKE ?', "%#{search}%"])
      else
        Student.all
      end
    end
  def self.sc_school(search)
        if search
          Student.where(['school LIKE ?', "%#{search}%"])
        else
          Student.all
        end
      end
    def self.sc_field(search)
          if search
            Student.where(['field LIKE ?', "%#{search}%"])
          else
            Student.all
          end
        end
end
