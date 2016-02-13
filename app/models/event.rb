class Event 

  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :type, :date_one, :date_two, :date_three

  validates :name, presence: true

  validates :email, presence: true

  validates :type, presence: true

  validates :date_one, presence: true

  validates :date_two, presence: true

  validates :date_three, presence: true

end