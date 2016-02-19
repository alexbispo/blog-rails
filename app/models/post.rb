class Post < ActiveRecord::Base
  include ImageSaver

  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one :image, dependent: :destroy, as: :imageable
  validates :title, length: { minimum: 3, maximum: 255 }
  validates_presence_of :content, :category, :user
  default_scope { order('created_at DESC') }

  before_save :generate_html

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  def to_s
    self.title
  end

  private
  def generate_html
    self.content_html = RDiscount.new(self.content).to_html
  end
end
