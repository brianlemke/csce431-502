# == Schema Information
#
# Table name: posters
#
#  id         :integer          not null, primary key
#  file       :string(255)
#  title      :string(255)
#  verified   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Poster < ActiveRecord::Base
  attr_accessible :file, :title, :verified
  mount_uploader :file, PosterUploader
end
