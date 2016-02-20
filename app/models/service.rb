class Service < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  enum name: [ :netflix, :google, :amazon, :dvd, :bluray, :other ]
end
