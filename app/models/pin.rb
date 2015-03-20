class Pin < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	validates :description, presence: true
	validates :image, presence: true

  geocoded_by :address
  after_validation :geocode 

  markable_as :offer, :request

  def self.search(address)
    near(address)
  end
end

