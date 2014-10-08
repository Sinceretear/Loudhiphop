
class SearchController < ApplicationController

  def index  
    
    require 'mechanize'
    require 'nokogiri'
    require 'open-uri'
    agent = Mechanize.new
    page = agent.get('http://www.audiomack.com/songs/day') 
    @post_links = page.search('h3.artist-title a')
	@post_links.attr('href')

	agent2 = Mechanize.new 
	page2 = agent2.get('http://www.hotnewhiphop.com/archive/')
	@hnhh_songs = page2.search('.list-item-title a')
	@hnhh_songs.attr('href')

	agent3 = Mechanize.new 
	page3 = agent.get('http://www.audiocastle.net/tracks/browse')
	@audiocastle = page3.search('.lighten_content a')
	@audiocastle.attr('href')

	agent4 = Mechanize.new 
	page4 = agent4.get('http://www.hiphopearly.com/')
	@hiphopearly = page4.search('.text')
	@hiphopearly.attr('href')

  end    

  def youtube_search
    
  end 

  def playlist
    
  end 
 
end 

