class Category < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  validates :name, length: { minimum: 3, maximum: 50 }
end
