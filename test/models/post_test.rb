# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  artist        :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  images        :text
#  slug          :string(255)
#  original_site :string(255)
#  Links         :string(255)
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
