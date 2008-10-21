xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title("Shirts")
    xml.description("All the new shirts at nitrocotton.com")
    xml.link(formatted_shirts_url(:rss))
    
    for shirt in @shirts
      xml.item do
        xml.title(shirt.name)
        xml.description(
          image_tag(shirt.image.public_filename) + "<br />" + shirt.description)
        xml.pubDate(shirt.created_at.to_s(:rfc822))
        xml.link(formatted_shirt_url(shirt, :rss))
        xml.guid(formatted_shirt_url(shirt, :rss))
      end
    end
  end
end
