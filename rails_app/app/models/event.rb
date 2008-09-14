class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :repodb
end
