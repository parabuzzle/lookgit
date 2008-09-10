class Key < ActiveRecord::Base
  belongs_to :user
  belongs_to :repos
end
