class User < ActiveRecord::Base
  has_and_belongs_to_many :repos
  has_many :keys

  attr_accessor :remember_me

    USERNAME_MIN_LENGTH = 4
    USERNAME_MAX_LENGTH = 20
    PASSWORD_MIN_LENGTH = 4
    PASSWORD_MAX_LENGTH = 20
    EMAIL_MAX_LENGTH = 50
    USERNAME_RANGE = USERNAME_MIN_LENGTH..USERNAME_MAX_LENGTH
    PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH

    #Text field constraints
    USERNAME_SIZE = 30
    PASSWORD_SIZE = 30
    EMAIL_SIZE =30

    validates_uniqueness_of :username, :email
    validates_length_of :username, :within => USERNAME_RANGE
    validates_length_of :password, :within => PASSWORD_RANGE
    validates_length_of :email, :maximum => EMAIL_MAX_LENGTH

    validates_format_of :username,
                            :with => /^[A-Z0-9_]*$/i,
                            :message => "must contain only letters, " + "numbers, and underscores."

    validates_format_of :email,
                            :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i


    #log a user in
    def login!(session)
      session[:user_id] = self.id
    end

    #log a user out
    def self.logout!(session, cookies)
      session[:user_id] = nil
      cookies.delete(:authorization_token)
    end

    #clear the password param
    def clear_password!
      self.password = nil
    end

    #Remember me stuff
    def remember!(cookies)
      cookie_expiration = 10.years.from_now
      cookies[:remember_me] = { :value => "1",
                                :expires => cookie_expiration}
      self.authorization_token = unique_identifier
      self.save!
      cookies[:authorization_token] = {
          :value => self.authorization_token.to_s,
          :expires => cookie_expiration }
    end

    def forget!(cookies)
      cookies.delete(:remember_me)
      cookies.delete(:authorization_token)
    end

    def remember_me?
      remember_me == "1"
    end

    private

    #generate unique identifier for remember me cookies
    def unique_identifier
      Digest::SHA1.hexdigest("#{username}:#{password}")
    end
  
end
