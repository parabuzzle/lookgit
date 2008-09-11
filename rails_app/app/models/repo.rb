class Repo < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :keys, :through => :users
  
  NAME_MIN_LENGTH = 4
  NAME_MAX_LENGTH = 20
  NAME_RANGE = NAME_MIN_LENGTH..NAME_MAX_LENGTH

  #Text field constraints
  NAME_SIZE = 30
  PASSWORD_SIZE = 30
  EMAIL_SIZE =30

  validates_uniqueness_of :name
  validates_length_of :name, :within => NAME_RANGE

  validates_format_of :name,
                          :with => /^[A-Z0-9_]*$/i,
                          :message => "must contain only letters, " + "numbers, and underscores."

  
  
end
