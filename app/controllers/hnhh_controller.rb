class HnhhController < ApplicationController


def index
	@Hnhh = HnhhDb.all

end 

def show

	@Hnhh = HnhhDb.friendly.find(params[:id])

    barn = params[:id]
    @example = HnhhDb.friendly.find(barn).artist 

    #require 'youtube_search'
    #this API no longer works due to youtube moving to new API version v3
    
    #use this gem https://github.com/Fullscreen/yt
    # https://github.com/Fullscreen/yt#configuring-your-app
    require 'yt'

    #this interacts with the youtube API v3
    Yt.configure do |config|
      config.api_key = 'AIzaSyBU6ZeJtu_uw0HSLd0XklyiJHVj6B9c5wI'
    end

    #this is in documentation of the yt gem. 
    videos = Yt::Collections::Videos.new
    @spacejam = videos.where( q: @Hnhh.artist, safe_search: 'none').first.id
    

    
    require 'mechanize'
        require 'nokogiri'
        require 'open-uri'

        agent = Mechanize.new
    page = agent.get('http://www.google.com') 
    search_form = page.form_with(:name => 'f')
    google_search =  @Hnhh.artist.delete("&").gsub(/\s+/, " ") + ' download'
    search_form.field_with(:name => 'q').value = google_search.to_s
    search_results = agent.submit(search_form)
    @google_links = search_results.search('.r a')



end 

 private
  def post_params
  	params.require(:Hnhh).permit(:title, :artist, :images)
  end 

end
