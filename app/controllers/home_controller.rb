class HomeController < ApplicationController
   def index
      require 'open-uri'
      doc = Nokogiri::HTML(open("http://www.uenf.br/portal/index.php/br/"))
      main = doc.css('#maincontent') #maincontent h3.title span | div.contentmod div.custom p
      @scrape_array_class = Array.new
      @titles = Array.new
      @contents = Array.new

      main.each do |c|

        c.css('h3.title').each do |title|
          @titles << title.at_css('span').text
        end
        c.css('.custom').each do |co|
           @contents << co.at_css('p').text
        end
    end

    0.upto(@titles.size) do |i|
      @scrape_array_class << Scrape.new(@titles[i],@contents[i])
    end
  end
end
