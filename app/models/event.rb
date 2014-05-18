class Event < ActiveRecord::Base

  belongs_to :user
  has_many :attendees, :class_name => 'EventAttendee'

end