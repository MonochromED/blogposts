class User < ActiveRecord::Base
  require 'bcrypt'
  attr_accessor :password
  attr_accessor :password_confirmation #from User Registration Form
  before_save :encrypt_password, :on => :create

  validates :userid, :uniqueness => true  
  validates_confirmation_of :password, :on => :create
  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create
  validate :password_matches_password_confirmation, :on => :create

  has_one :avatar
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)

    end
  end



  def self.authenticate(user_name, password)
    user = find_by_userid(user_name)
    if (user)
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user  
      end
    end
  end


  def password_matches_password_confirmation
    if password === password_confirmation
      true
    else
      false
    end
  end


end

