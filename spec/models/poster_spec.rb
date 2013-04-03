# == Schema Information
#
# Table name: posters
#
#  id              :integer          not null, primary key
#  file            :string(255)
#  title           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :string(255)
#

require 'spec_helper'

describe Poster do
end
