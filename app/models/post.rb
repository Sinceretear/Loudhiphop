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
