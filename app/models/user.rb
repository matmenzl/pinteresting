require "markable"
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  acts_as_marker

  has_many :pins

  validates :name, presence: true

  after_create :send_notification

  geocoded_by :address
  after_validation :geocode 

  def send_notification
  	AdminMailer.new_user(self).deliver
  end

  def build_markers(location = nil)
    pins = Pin.near(address.blank? ? location : address)
    markers = Gmaps4rails.build_markers(pins) do |pin, marker|
      marker.lat pin.latitude
      marker.lng pin.longitude
      marker.picture({
              :picture => pin.image.url,
              :width   => 32,
              :height  => 32
             })
      marker.title pin.user.name
      marker.infowindow pin.gmaps_infowindow
    end
  end
end
