class Song < ActiveRecord::Base
	extend FriendlyId
		friendly_id :artist, use: :slugged
end
