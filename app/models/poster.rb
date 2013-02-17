class Poster < ActiveRecord::Base
  attr_accessible :file, :title, :verified
  mount_uploader :file, PosterUploader
end
