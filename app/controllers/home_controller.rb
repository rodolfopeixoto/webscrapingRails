class HomeController < ApplicationController
   def index
      require 'open-uri'
      doc       = Nokogiri::HTML(open("http://www.uenf.br/portal/index.php/br/"))
      main      = doc.css('#maincontent') #maincontent h3.title span | div.contentmod div.custom p
      @contents = Array.new
      @links = Array.new
      @titles = Array.new
      @headers = Array.new

      main.each do |c|



          c.css("h3.title").each_with_index do |title,i|
            is_content(i,8, @titles, title.at_css('span').text)
          end
          c.css('.custom').each_with_index do |co,i|
            is_content(i,8, @contents, co.at_css('p').text)
          end

          c.css('strong a').each_with_index do |co,i|
            is_content(i,8,@links,co.attribute('href').to_s)
          end
    end


     menus      = doc.css('ul.menu.accordion') #maincontent h3.title span | div.contentmod div.custom p
      menus.each do |menu|
        menu.css("li span.separator").each do |item|
          @headers << item.at_css('span').text
        end
      end



    create_scrape(@titles.size)
    create_header(@headers.size)

  end

  def create_scrape(array_titles)
    @scrape_array_class = Array.new

    0.upto(array_titles) do |i|
      @scrape_array_class << Scrape.new(@titles[i],@contents[i],@links[i])
    end
  end


  def create_header(array_titles)
    @headers_array_class = Array.new

    0.upto(array_titles) do |i|
      @headers_array_class << Header.new(@headers[i])
    end
  end

  def is_content(i,count, variable_array, content_parse)
    if i < count
      variable_array << content_parse
    end
  end

end
