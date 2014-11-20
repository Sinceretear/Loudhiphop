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

class HnhhDb < ActiveRecord::Base

	extend FriendlyId
		friendly_id :artist, use: :slugged


end
