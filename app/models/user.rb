class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable,  :omniauth_providers => [:facebook, :twitter, :github]

  has_many :identities
  has_many :links
  has_many :events
  has_many :attending_events, :class_name => 'EventAttendee'

end
