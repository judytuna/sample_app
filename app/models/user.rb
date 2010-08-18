# == Schema Information
# Schema version: 20100804080220
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'digest' # Can't hurt - may be optional

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :name, :email
  validates_length_of :name, :maximum => 50
  validates_format_of :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false

  #Automatically create the virtual attribute 'password_confirmation'.
  validates_confirmation_of :password
 
  #Password validations.
  validates_presence_of :password
  validates_length_of :password, :within => 6..40

  before_save :encrypt_password

  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    #compare encrypted_password w/ the encrypted version of submitted_password
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password) #could say User.authenticate
    user = find_by_email(email)
    #  return nil if user.nil? #that email isn't in our database
    #  return user if user.has_password?(submitted_password) #got the user
    #  # third case is implicit: password mismatch, reaches end of method, 
    #  # automatically returns nil
    
    # listing 7.28 and 7.29 ... using if statements
    #  if user.nil?
    #    nil
    #  elsif user.has_password?(submitted_password)
    #    user
    #  else
    #    nil
    #  end

    # listing 7.30
    user && user.has_password?(submitted_password) ? user : nil
       # if user and user.haspw are both true, then return user
       # if not, then return nil
  end

  private # only internal - outside things can't call these

    def encrypt_password
      self.salt = make_salt
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end

