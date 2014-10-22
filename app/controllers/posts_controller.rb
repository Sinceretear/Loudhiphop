class PostsController < ApplicationController
  
  before_filter :authenticate_user!, except: [ :show, :index, :new, :create ] 

  def index
  	@posts = Post.all 
    @posts = Post.paginate(:page => params[:page], :per_page => 6,).order('created_at DESC')

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


        page1 = agent.get('http://www.audiomack.com/songs/day') 
        @post_links = page1.search('h3.artist-title a')
        @post_links.attr('href')
        @audiomack_images = page1.search('.cover img')
        @jam = Hash[@post_links.zip(@audiomack_images)]

        page13 = agent.get('http://www.audiomack.com/trending')
        @trending_links = page13.search('.artist-title a')
        @trending_images = page13.search('.cover img')
        @trending_hash = Hash[@trending_links.zip(@trending_images)]

        page2 = agent.get('http://www.hotnewhiphop.com/archive/')
        @hnhh_songs = page2.search('.list-item-title a')
        @hnhh_songs.attr('href')

        @hnhh_images = page2.search('.image38')

        @hnhh_hash = Hash[@hnhh_songs.zip(@hnhh_images)]

  end

  def show #retrive and display individual post	
  	@posts = Post.find(params[:id])

    barn = params[:id]
    @example = Post.find(barn).artist + " " + Post.find(barn).title 

    require 'youtube_search'
    @search_results = YoutubeSearch.search( @example,'order_by' => 'viewcount').first['video_id']

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
  
