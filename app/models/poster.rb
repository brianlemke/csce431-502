# == Schema Information
#
# Table name: posters
#
#  id              :integer          not null, primary key
#  file            :string(255)
#  title           :string(255)
#  verified        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :string(255)
#

class Poster < ActiveRecord::Base
  attr_accessible :file, :title, :verified
  mount_uploader :file, PosterUploader
  belongs_to :organization
  validates_presence_of :file, :title, :verified
end
