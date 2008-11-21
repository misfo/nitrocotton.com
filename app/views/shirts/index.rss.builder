xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title("nitrocotton's newest shirts")
    xml.description("All the new shirts at nitrocotton.com")
    xml.link("http://feeds.feedburner.com/nitrocotton/newest_shirts")
    
    for shirt in @shirts
      xml.item do
        xml.title(shirt.name)
        xml.description(
          link_to(image_tag(shirt.image.public_filename), shirt_url(shirt)) + "<br />" +
          link_to("more...", shirt_url(shirt)) + "<br />" +
          link_to("#{shirt.merchant.name} link", shirt.merchant_url)
        )
        xml.pubDate(shirt.created_at.to_s(:rfc822))
        xml.link(shirt_url(shirt))
        xml.guid(shirt_url(shirt))
      end
    end
  end
end
