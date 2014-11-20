class HnhhController < ApplicationController


def index
	@Hnhh = HnhhDb.all

end 

def show

	@Hnhh = HnhhDb.friendly.find(params[:id])

    barn = params[:id]
    @example = HnhhDb.friendly.find(barn).artist 

    require 'youtube_search'
    @search_results = YoutubeSearch.search( @example,'order_by' => 'viewcount').first['video_id']

    

    
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
