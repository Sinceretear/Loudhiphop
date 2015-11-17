

class SearchController < ApplicationController

   def requires 
    require 'mechanize'
    require 'nokogiri'
    require 'open-uri'
  end 


  def index  
    @News = News.all

    @mixtape = Mixtapes.all
  

  end   

  def news 

    @News = News.all
    
  	requires

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







  end 

  def hotnewhiphop
    requires

    agent2 = Mechanize.new 


    page2 = agent2.get('http://www.hotnewhiphop.com/archive/')


    @hnhh_songs = page2.search('.songChart img')
    
        #@hnhh_songs.attr('href')
    
        @hnhh_links = page2.search('.songChart-cover-anchor')
    
        @hnhh_hash = @hnhh_links.zip(@hnhh_songs)

        @hnhh_hash.each do |x, i|
          hnhh_link = "http://www.hotnewhiphop.com" + x.attr('href').to_s
          image_link = i.attr('src').to_s
          artist_name_title = x.attr('title').to_s

        end 

    
  end 

  def audiomack
    requires

    agent = Mechanize.new
    page = agent.get('http://www.audiomack.com/songs/day') 
    #scrapes all other data from audiomack top 10 songs/day
        @post_links = page.search('.player_image')

        #scrapes the images from audiomack top 10
        @audiomack_images = page.search('.player_image img')
 
        #the line below was experimentation. It zips the images array into the postlinks array. Might want to look into the .flatten mathod later
        #@new_array = @audiomack_images.zip(@post_links)

        #jam is the cominded array of postlinks and audiomack images
        @jam = @audiomack_images.zip(@post_links)




=begin
    page13 = agent.get('http://www.audiomack.com/trending')
    @trending_links = page13.search('.artist-title a')
    @trending_images = page13.search('.cover img')
    @trending_hash = Hash[@trending_links.zip(@trending_images)]
=end
=begin
    #Take our search array, insert it into a query
    search_terms.each do |search|
    page = agent.get("http://www.asus.com/Search/?SearchKey=#{search}")
    links =  page.links.find_all{ |l| l.text =~ /#{search}/i}
    links.each { |links_text| results_file.write( "#{links_text}\n" ) }
    end 

    var = page.search('.artist-title')
    page15 = agent.get('http://www.google.com')
    google = page15.form
    search_term = var[0].text
    google.field_with(:name => "q").value = search_term
    @search_results = agent.submit(google)
=end 
    
  end



  def hiphopearly
    requires

    agent4 = Mechanize.new 
    page4 = agent4.get('http://www.hiphopearly.com/')
    @hiphopearly = page4.search('.text')
    @hiphopearly.attr('href')

    @hhe_images = page4.search('#left-column .thumb')

    @hhehash = Hash[@hiphopearly.zip(@hhe_images)]


    
  end 

  def audiocastle
    requires

    agent3 = Mechanize.new 
    page3 = agent3.get('http://www.audiocastle.net/tracks/browse')
    @audiocastle = page3.search('a .lighten_content li, a')
    @audiocastle.attr('href')

    
  end 

  def mixtapes 
    requires 

    @mixtape = Mixtapes.all

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


 

  def videos
      requires  

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



  end 

  def worldstar
  end 

  def howflyhiphop
    requires

      agent9 = Mechanize.new 
      page9 = agent9.get('http://www.howflyhiphop.com/category/singles/')
      @hfhh_links = page9.search('.entry-title a')
      @hfhh_images = page9.search('.size-full')
      @hfhh_hash = Hash[@hfhh_links.zip(@hfhh_images)]

      page10 = agent9.get('http://www.howflyhiphop.com/category/singles/page/2/')
      @hfhh_p2_links = page10.search('.entry-title a')
      @hfhh_p2_images = page10.search('.size-full')
      @hfhh_hash2 = Hash[@hfhh_p2_links.zip(@hfhh_p2_images)]

  end 


  def reddit
    requires

    agent11 = Mechanize.new
    page11 = agent11.get('http://www.reddit.com/r/trapmuzik/')
    @tm_links = page11.search('.title .may-blank')
    # @tm_links_native = page11.search('.self .title') <-- fix native reddit links later 
    @tm_images = page11.search('#siteTable .thumbnail img')

    @tm_hash = Hash[@tm_images.zip(@tm_links)]

    @tm = page11.search('.thumbnail may-blank img')




  end 


  
 
end 

