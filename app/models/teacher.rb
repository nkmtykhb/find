class Teacher < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true,uniqueness: true}
  validates :password, {presence: true,length: {minimum: 8}}
  def self.sc_name(search)
      if search
        Teacher.where(['name LIKE ?', "%#{search}%"])
      else
        Teacher.all
      end
    end
    def self.sc_school(search)
        if search
          Teacher.where(['school LIKE ?', "%#{search}%"])
        else
          Teacher.all
        end
      end
      def self.sc_field(search)
          if search
            Teacher.where(['field LIKE ?', "%#{search}%"])
          else
            Teacher.all
          end
        end

end
