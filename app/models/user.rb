require 'digest'

class User < ActiveRecord::Base

  
attr_accessible(:name, :email, :ip, :password, :password_confirmation, :kill)
attr_accessor :password
validates :name, :presence => true, :length => {:maximum =>50}
validates :ip, :presence => true, :uniqueness => { :case_sensitive => true },
  :length => {:within => 7..13}
                
  valid_mail =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

validates :email, :presence => true, :format => {:with => valid_mail},
                  :uniqueness => { :case_sensitive => true }
validates :password, :presence => true, :confirmation => true,
            :length => {:within => 6..40}
          
  
  before_save :encrypt_password
  
  # Return true if the user's password matches the submitted password.
def has_password?(submitted_password)
  encrypted_password == encrypt(submitted_password)
end

def self.authenticate(email, submitted_password)
  user = find_by_email(email)
  return nil if user.nil?
  return user if user.has_password?(submitted_password)
end

def self.authenticate_with_salt(id, cookie_salt)
 user = User.find_by_id(id)
 (user && user.email == cookie_salt) ? user : nil
end  



def find_ip(ip)
    user = User.find_by_ip(ip)
    return nil if user.nil?
    return user if !user.nil?
end 

  
  private 
  
  def encrypt_password
    self.encrypted_password = encrypt(password) if new_record?
  end
 
  
  def encrypt(string)
    Digest::SHA2.hexdigest(string)
  end
  


end
