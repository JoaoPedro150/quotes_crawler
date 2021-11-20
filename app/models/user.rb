class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :username, type: String
  field :password_digest, type: String
  
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 4 }

  has_secure_password
  
  index({name: 1}, {unique: true, name: 'user_name_index'})
end
