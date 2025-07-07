class Book < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy

  #enum status: { unread: 0, reading: 1, finished: 2}
  
end
