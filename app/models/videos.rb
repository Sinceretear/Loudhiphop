# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  image      :string(255)
#  link       :string(255)
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Videos < ActiveRecord::Base
end
