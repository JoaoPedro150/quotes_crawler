class QuotesController < ApplicationController
  before_action :authorize
  
  # GET /quotes
  def index
    render json: { quotes: Quote.all.as_json(only: [:quote, :author, :author_about, :tags ]) }
  end

  # DELETE /quotes
  def destroy
    Quote.delete_all
  end

  # GET /quotes/tag
  def show
    tag = params[:id]
    quotes = Quote.where(:tags.in => [ tag ])

    if quotes.empty?
      quotes = fetch_quotes_by_tag(tag)
    end

    render json: { quotes: quotes.as_json(only: [:quote, :author, :author_about, :tags ]) }
  end

  private
    def get_quotes() return Nokogiri::HTML(URI.open('http://quotes.toscrape.com/')).css('.quote') end
    def get_tags(xml_element) return xml_element.xpath('div/a[@class="tag"]') end
    def get_quote_content(xml_element) return xml_element.xpath('span[1]').text[1..-2] end
    def get_author(xml_element) return xml_element.xpath('span[2]/small').text end
    def get_author_about(xml_element) return 'http://quotes.toscrape.com' + xml_element.xpath('span[2]/a/@href').text end

    def get_quote(xml_element)
      quote = Quote.where(quote: get_quote_content(xml_element)).first

      if quote.nil?
        quote = Quote.new
        quote.quote = get_quote_content(xml_element)
        quote.author = get_author(xml_element)
        quote.author_about = get_author_about(xml_element)
        quote.associeted_tags = []  
      end
      return quote
    end

    def get_tag(tag_name)
      tag = Tag.where(name: tag_name).first

      if tag.nil?
        tag = Tag.new
        tag.name = tag_name
        tag.save
      end
      return tag
    end

    def fetch_quotes_by_tag(search_tag)
      quotes = []

      get_quotes().each do |quote_xml_element|
        quote_content = get_quote_content(quote_xml_element)
        
        quote = get_quote(quote_xml_element)

        get_tags(quote_xml_element).each do |tag_xml_element|
          if tag_xml_element.text == search_tag
            tag = get_tag(tag_xml_element.text)

            quote.associeted_tags << tag
            quote.save
            quotes << quote
          end
        end
      end
      return quotes
    end
end
