class User < ApplicationRecord
 has_secure_password
 has_many :books
 has_many :reviews
end
