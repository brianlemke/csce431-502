# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  body       :text
#  poster_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :poster
  attr_accessible :body, :email, :name

  validates_presence_of :name
  validates_length_of :name, :within => 2..20
  validates_presence_of :body
end
