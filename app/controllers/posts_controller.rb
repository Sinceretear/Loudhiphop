class PostsController < ApplicationController
  
  before_filter :authenticate_user!, except: [ :show, :index, :new, :create ] 

  def index
  	@posts = Post.all 
    @posts = Post.paginate(:page => params[:page], :per_page => 24,).order('created_at DESC')

    #require 'youtube_search'
    #@var = 'posed to be in love'
    #methods that coincide with this plugin: https://github.com/grosser/youtube_search
    #@search_results = YoutubeSearch.search( @var,'order_by' => 'viewcount').first['video_id']

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

        # audio mack links -- connected to the trending...scrapes 2 pages here. 
        page1 = agent.get('http://www.audiomack.com/songs/day') 
        @post_links = page1.search('h3.artist-title a')
        @post_links.attr('href')
        @audiomack_images = page1.search('.cover img')
        @jam = Hash[@post_links.zip(@audiomack_images)]

         @jam.each do |x, i|
          artist_name_title = x.text
          audiomack_link = "http://www.audiomack.com" + x.attr('href').to_s 
          image_link =  i.attr('src').to_s 

          if Post.exists?(:artist => artist_name_title)
            next
          else 
            Post.create(:artist => artist_name_title, :images => image_link, :title => audiomack_link)
          end 
        end 

        page13 = agent.get('http://www.audiomack.com/trending')
        @trending_links = page13.search('.artist-title a')
        @trending_images = page13.search('.cover img')
        @trending_hash = Hash[@trending_links.zip(@trending_images)]

        @trending_hash.each do |x, i|
          artist_name_title = x.text
          image_link =  i.attr('src').to_s 
          audiomack_link = "http://www.audiomack.com" + x.attr('href').to_s 
          if Post.exists?(:artist => artist_name_title)
            next
          else 
            Post.create(:artist => artist_name_title, :images => image_link, :title => audiomack_link)
          end 
        end 


        # hnhh scrapes 
        page2 = agent.get('http://www.hotnewhiphop.com/archive/')
        @hnhh_songs = page2.search('.list-item-title a')
        @hnhh_songs.attr('href')
        @hnhh_images = page2.search('.image38')
        @hnhh_hash = Hash[@hnhh_songs.zip(@hnhh_images)]

  end

  def show #retrive and display individual post	
  	@posts = Post.friendly.find(params[:id])

    barn = params[:id]
    @example = Post.friendly.find(barn).artist 

    require 'youtube_search'
    @search_results = YoutubeSearch.search( @example,'order_by' => 'viewcount').first['video_id']

    google_search =  @posts.artist.delete("&").gsub(/\s+/, " ") + ' download'

    
    require 'mechanize'
        require 'nokogiri'
        require 'open-uri'

        agent = Mechanize.new
    page = agent.get('http://www.google.com') 
    search_form = page.form_with(:name => 'f')
    search_form.field_with(:name => 'q').value = google_search.to_s
    search_results = agent.submit(search_form)
    @google_links = search_results.search('.r a')

  end 

  def new 
  	@posts = Post.new
  end 

  def create #no view
  	@posts = Post.new(post_params)

  	if @posts.save
  		redirect_to posts_path, :notice => "your post was saved"
  	else 
  		render "new"
  	end 	

  end

  def edit
  	@posts = Post.find(params[:id])
  end 

  def update #no view
  	@posts = Post.find(params[:id])
  	if @posts.update_attributes(post_params)
  		redirect_to posts_path, :notice => "your post has been updated"
  	else 
  		render "edit"
  	end 
  end 

  def destroy #no view
  	@posts = Post.find(params[:id])
  	@posts.destroy
  	redirect_to posts_path, :notice => "post deleted hoe!"
  end 

  def import 
    Post.import(params[:file])
    redirect_to posts_path, notice: "songs imported."
  end 


  private
  def post_params
  	params.require(:post).permit(:title, :artist, :images)
  end 

end  

