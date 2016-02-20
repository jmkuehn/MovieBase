class Movie < ActiveRecord::Base
  belongs_to :user
  has_many :services

  validates :watched, presence: true
end
