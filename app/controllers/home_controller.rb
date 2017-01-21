class HomeController < ApplicationController
   def index
      require 'open-uri'
      doc = Nokogiri::HTML(open("http://www.uenf.br/portal/index.php/br/"))
      main = doc.css('#maincontent') #maincontent h3.title span | div.contentmod div.custom p
      @titles = Array.new
      @contents = Array.new

      main.each do |c|



          c.css("h3.title").each_with_index do |title,i|
            is_content(i,8, @titles, title.at_css('span').text)
          end
          c.css('.custom').each_with_index do |co,i|
            is_content(i,8, @contents, co.at_css('p').text)
          end
    end

    create_scrape(@titles.size)

  end

  def create_scrape(array_titles)
    @scrape_array_class = Array.new

    0.upto(array_titles) do |i|
      @scrape_array_class << Scrape.new(@titles[i],@contents[i])
    end
  end

  def is_content(i,count, variable_array, content_parse)
    if i < count
      variable_array << content_parse
    end
  end
end
