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
#

class Post < ActiveRecord::Base

	#validates :title, :artist, :presence => true
	#validates :title , :length => { :minimum => 2 }
	#validates :title, :uniqueness => true
	extend FriendlyId
		friendly_id :artist, use: :slugged


	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			Post.create! row.to_hash
		end		
	end 

end
