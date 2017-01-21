class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

   def header
      require 'open-uri'
      doc       = Nokogiri::HTML(open("http://www.uenf.br/portal/index.php/br/"))
      main      = doc.css('.menu .accordion') #maincontent h3.title span | div.contentmod div.custom p
      @headers = Array.new

      main.each do |c|



          c.css("li span").each_with_index do |item,i|
            # is_content(i,8, @headers, item.at_css('span').text)
            puts "Aqui; #{item.at_css('span').text}"
          end
    end

    create_scrape(@headers.size)

  end

  def create_scrape(array_titles)
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
