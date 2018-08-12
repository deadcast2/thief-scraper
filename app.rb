require 'nokogiri'
require 'open-uri'

mission_list = Nokogiri::HTML(open('http://thiefmissions.com/search.cgi?search=&sort=release#m'))
mission_list.xpath('//a[starts-with(@href, "/m/")]').each do |mission_link|
  href = mission_link.attributes['href'].value
  name = href.slice(3, href.size)
  download_page = Nokogiri::HTML(open("http://thiefmissions.com/download.cgi?m=#{name}&noredir=1"))
  download_page.xpath('//a[starts-with(@href, "/dl/")]').each do |download_link|
    partial_href = download_link.attributes['href'].value
    `wget --random-wait "http://thiefmissions.com#{partial_href}" -P missions`
  end
end
