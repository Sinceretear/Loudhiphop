class PostsController < ApplicationController
  
  before_filter :authenticate_user!, except: [ :show, :index, :new, :create ] 

  def index
  	@posts = Post.all 
    @posts = Post.paginate(:page => params[:page], :per_page => 24,).order('created_at DESC')

    @Hnhh = HnhhDb.all
    @Hnhh = HnhhDb.paginate(:page => params[:page], :per_page => 24,).order('created_at DESC')

    @News = News.all
    @News = News.paginate(:page => params[:page], :per_page => 10,).order('created_at DESC')

    @videos = Videos.all 
    @videos = Videos.paginate(:page => params[:page], :per_page => 10,).order('created_at DESC')

    @mixtape = Mixtapes.all
    @mixtape = Mixtapes.paginate(:page => params[:page], :per_page => 24,).order('created_at DESC')

    #require 'youtube_search'
    #@var = 'posed to be in love'
    #methods that coincide with this plugin: https://github.com/grosser/youtube_search
    #@search_results = YoutubeSearch.search( @var,'order_by' => 'viewcount').first['video_id']


        require 'mechanize'
        require 'nokogiri'
        require 'open-uri'
        agent = Mechanize.new


        # audio mack links -- connected to the trending...scrapes 2 pages here. 
        agent = Mechanize.new
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
            Post.create(:artist => artist_name_title, :images => image_link, :title => audiomack_link, :original_site => "Audiomack")
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
            Post.create(:artist => artist_name_title, :images => image_link, :title => audiomack_link, :original_site => "Audiomack")
          end 
        end 

        # hnhh scrapes 
        page2 = agent.get('http://www.hotnewhiphop.com/archive/')
        @hnhh_songs = page2.search('.list-item-title a')
        @hnhh_songs.attr('href')
        @hnhh_images = page2.search('.image38')
        @hnhh_hash = Hash[@hnhh_songs.zip(@hnhh_images)]

        @hnhh_hash.each do |x, i|
          hnhh_link = x.attr('href').to_s
          image_link = i.attr('src').to_s
          artist_name_title = x.text

        if HnhhDb.exists?(:artist => artist_name_title)
            next
          else 
            HnhhDb.create(:artist => artist_name_title, :images => image_link, :title => hnhh_link, :original_site => "HotNewHipHop")
          end 
        end 

        #code for the videos. this index method is getting bloated
        agent5 = Mechanize.new 
      page5 = agent5.get('http://www.hiphopdx.com/index/videos/p.1')
      @videos_hhdx = page5.search('h3 a')

      @hhdx_images = page5.search('#wirelist2 img')

      @hhdx_hash = Hash[@videos_hhdx.zip(@hhdx_images)]

      agent6 = Mechanize.new 
      page6 = agent6.get('http://www.hotnewhiphop.com/videos/ ')
      @hnhh_video_links = page6.search('.list-item-title a')
      @hnhh_video_images = page6.search('.video-thumb .w100per')
      @hnhh_video_hash = Hash[@hnhh_video_links.zip(@hnhh_video_images)]


      # code for the news 

      agent = Mechanize.new
      page = agent.get('http://www.hotnewhiphop.com/articles/news/')
      @news_links = page.search('.title-10 a')
      @news_links.shift
      @images = page.search('.mr10 img')

      #zip and map the arrays to display

      @pit = Hash[@news_links.zip(@images)]


      @pit.each do |x, i|
            artical_name_title = i.attr('alt').to_s
            news_link = x.attr('href').to_s
            image_link =  i.attr('src').to_s

            if News.exists?(:title => artical_name_title)
              next
            else 
              News.create(:title => artical_name_title, :image => image_link, :link => news_link)
            end 
          end

      #VIDEOS 
      agent5 = Mechanize.new 
      page5 = agent5.get('http://www.hiphopdx.com/index/videos/p.1')
      @videos_hhdx = page5.search('h3 a')
      @hhdx_images = page5.search('#wirelist2 img')
      @hhdx_hash = Hash[@videos_hhdx.zip(@hhdx_images)]

      @hhdx_hash.each do |x, i|
            video_title = x.text
            site_link = "http://www.hiphopdx.com" + x.attr('href').to_s 
            image_link =  i.attr('src').to_s

            if Videos.exists?(:title => video_title)
              next
            else 
              Videos.create(:title => video_title, :image => image_link, :link => site_link)
            end 
          end


      agent6 = Mechanize.new 
      page6 = agent6.get('http://www.hotnewhiphop.com/videos/ ')
      @hnhh_video_links = page6.search('.list-item-title a')
      @hnhh_video_images = page6.search('.video-thumb .w100per')
      @hnhh_video_hash = Hash[@hnhh_video_links.zip(@hnhh_video_images)]

      @hnhh_video_hash.each do |x, i|
            video_title = x.text
            site_link = x.attr('href')
            image_link =  i.attr('src')

            if Videos.exists?(:title => video_title)
              next
            else 
              Videos.create(:title => video_title, :image => image_link, :link => site_link)
            end 
          end

      #controller getting more bloated with the advent of the MIXTAPES DB

          agent7 = Mechanize.new 
        page7 = agent7.get('http://www.livemixtapes.com/main.php')
        @lm_links = page7.search('#content span a')
        @lm_images = page7.search('.mixtape_cover img')
        @lm_hash = Hash[@lm_links.zip(@lm_images)]

        @lm_hash.each do |x, i|
              artist_name_title = x.text
              image_link =  i.attr('src').to_s 
              livemixtapes_link = "http://www.livemixtapes.com" + x.attr('href').to_s 

              if Mixtapes.exists?(:artist => artist_name_title)
                next
              else 
                Mixtapes.create(:artist => artist_name_title, :mx_cover => image_link, :mx_name => livemixtapes_link)
              end 
            end 


          agent8 = Mechanize.new
          page8 = agent8.get('http://www.datpiff.com/')
          @dp_links = page8.search('#leftColumnWide .title a')
          @dp_images = page8.search('#leftColumnWide .contentThumb img')
          @dp_artist = page8.search('.artist')
          @dp_hash = Hash[@dp_links.zip(@dp_images)]

          @new_array = @dp_links.zip(@dp_images, @dp_artist)

          @new_array.each do |x, i, z| 
            dp_link = "http://www.datpiff.com" + x.attr('href')
            dp_image = i.attr('src') 
            dp_artist = x.attr('title').to_s.gsub(/^(listen to )/, '') 
            dp_mxname = z.text 

            if Mixtapes.exists?(:artist => dp_artist)
                next
              else 
                Mixtapes.create(:artist => dp_artist, :mx_cover => dp_image, :mx_name => dp_mxname, :mx_artist =>dp_link )
              end 
          end

  end

  def show #retrive and display individual post	
  	@posts = Post.friendly.find(params[:id])

    barn = params[:id]
    @example = Post.friendly.find(barn).artist 

    require 'youtube_search'
    @search_results = YoutubeSearch.search( @example,'order_by' => 'viewcount').first['video_id']

    

    
    require 'mechanize'
        require 'nokogiri'
        require 'open-uri'

        agent = Mechanize.new
    page = agent.get('http://www.google.com') 
    search_form = page.form_with(:name => 'f')
    google_search =  @posts.artist.delete("&").gsub(/\s+/, " ") + ' download'
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

