require "net/http"
require "cgi"

plugin :google, "hledej na Google" do |*words|
  response = Net::HTTP::get_response('www.google.com', "/search?q=#{CGI::escape(words.join(" "))}&ie=utf-8&oe=utf-8")
  result = Array.new
  response.body.scan(/<a class=l href="(.+?)">(.+?)<\/a>/) do |*args|
    result.push("#{title}: #{url}")
  end
  #TODO: replace <b> & </b> by * in this way ->  *word*
  result.each do |link|
    muc.say(link)
  end
  #response.body.scan(/<a class=l href="(.+?)">(.+?)<\/a>/) do
  #  result.push("#{$2}: #{$1}")
  #end
end
