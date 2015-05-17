require "markable"
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  acts_as_marker

  has_many :pins, dependent: :destroy

  validates_presence_of :name, :zip, :street, :city, :country

  after_create :send_notification

  geocoded_by :geocoder_param
  after_validation :geocode

  after_create :make_address
  after_create :notify_neighbours

  def send_notification
  	AdminMailer.new_user(self).deliver
  end

  def build_markers pins
    markers = Gmaps4rails.build_markers(pins) do |pin, marker|
      marker.lat pin.latitude
      marker.lng pin.longitude
      marker.picture({
              :picture => pin.image.url,
              :width   => 32,
              :height  => 60
             })
      marker.title pin.user.name
      marker.infowindow pin.gmaps_infowindow
    end
  end

  def geocoder_param
    "#{street}, #{city}, #{country}"
  end

  def make_address
    update_attributes(address: "#{street}, #{city}, #{country}")
  end

  def notify_neighbours
    NearbyMailer.user_notify(self).deliver
  end
end
