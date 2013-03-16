class Comment < ActiveRecord::Base
  belongs_to :poster
  attr_accessible :body, :email, :name
end
