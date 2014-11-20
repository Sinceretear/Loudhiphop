# == Schema Information
#
# Table name: hnhh_dbs
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  artist        :string(255)
#  images        :string(255)
#  slug          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  original_site :string(255)
#

require 'test_helper'

class HnhhDbTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
