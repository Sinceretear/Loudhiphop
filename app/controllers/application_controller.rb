class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
  	search_playlist_path
  end 


  before_filter :news
		 def news 
		  	require 'mechanize'
		    require 'nokogiri'
		    require 'open-uri'

		    agent = Mechanize.new
		    page = agent.get('http://www.hotnewhiphop.com/articles/news/')
		    @news_links = page.search('.title-10 a')
		    @news_links.shift
		    @images = page.search('.mr10 img')

		    #zip and map the arrays to display

		    @pit = Hash[@news_links.zip(@images)]
		end 

end
