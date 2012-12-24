class User < ActiveRecord::Base
  attr_accessible :api_key, :email, :full_name

  validates_presence_of :email, :full_name
  validates_length_of :full_name, minimum: 3, maximum: 25
  validates :email, email_format: true
end
