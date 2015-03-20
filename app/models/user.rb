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
end
