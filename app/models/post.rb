class Post < ActiveRecord::Base

	#validates :title, :artist, :presence => true
	#validates :title , :length => { :minimum => 2 }
	#validates :title, :uniqueness => true


	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			Post.create! row.to_hash
		end		
	end 

end
