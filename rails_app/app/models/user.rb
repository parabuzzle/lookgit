class User < ActiveRecord::Base
  
  has_many :repodbs
  has_many :keys
  has_many :watchers
  has_many :members
  has_many :events
  has_one :profile

  attr_accessor :remember_me
  attr_accessor :repevents

    USERNAME_MIN_LENGTH = 4
    USERNAME_MAX_LENGTH = 20
    PASSWORD_MIN_LENGTH = 4
    PASSWORD_MAX_LENGTH = 20
    EMAIL_MAX_LENGTH = 50
    USERNAME_RANGE = USERNAME_MIN_LENGTH..USERNAME_MAX_LENGTH
    PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH
    DISALLOWED_USERNAMES = 'user repo repository creator mine profile perforce'

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




    
    def validate
      for name in DISALLOWED_USERNAMES.split(" ")
        if self[:username] == name
          valid = false
          break
        end
      end
      if
        valid == false
        errors.add_to_base "That username is disallowed... sorry."
      end
    end

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
      self.password_confirmation = nil
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
    def repevents
  		list = []
  		repodbs.each do |repo|
  			list += repo.events
  		end
  		list
  	end

    private

    #generate unique identifier for remember me cookies
    def unique_identifier
      Digest::SHA1.hexdigest("#{username}:#{password}")
    end
  
end