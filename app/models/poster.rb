# == Schema Information
#
# Table name: posters
#
#  id              :integer          not null, primary key
#  file            :string(255)
#  title           :string(255)
#  description     :string(255)
#  tag             :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :string(255)
#

class Poster < ActiveRecord::Base
  attr_accessible :file, :title, :description, :tag, :event_date
  mount_uploader :file, PosterUploader
  belongs_to :organization
  
  has_many :comments, :dependent => :destroy
end
