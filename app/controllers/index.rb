require 'net/http'
require 'httparty'
require 'json'

get '/' do
  @sky_api = "480027597b1e09227c293166af83a3a1" # ENV[DARKSKY_ACCESS_TOKEN]
  @spotify_api = "e854c332c665412f958e01358335a7f2" #ENV[SPOTIFY_ACCESS_TOKEN]
 #  p params
 #  response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?q=London&APPID=34f140e07bf944172a966ff9d0c0cb8f")
 # p @weather = response.parsed_response["weather"].first['main']
# uri = URI(url)
# response = Net::HTTP.get(uri)
#  parsed = JSON.parse(response)
 # p JSON.parse(url)

#@artists = RSpotify::Artist.search('Arctic Monkeys')


  erb :index
end

get '/callback' do
   @code = params[:code]
   @client_id = "e854c332c665412f958e01358335a7f2"
   @client_secret = "f65e46b7a8df4efc90fce0a8544935ab"
#    puts "stuff"
    p params
#    puts "more stuff"
#   params[:client_id]
#   puts "STUFF"
#    params[:client_secret]
#   # uri = URI('https://www.spotify.com/us/')
#   # @new_uri = Net::HTTP.get(uri)
#   response = HTTParty.get('http://api.stackexchange.com/2.2/questions?site=stackoverflow')

# puts response.body, response.code, response.message, response.headers.inspect
  erb :callback
end

post 'https://accounts.spotify.com/api/token' do
  # @grant_type = "authorization_code"
  # @code = params[:code]
  p params
  # @redirect_uri = 'http://localhost:9393/callback'
  # @client_id = params[:client_id]
  # @client_secret = params[:client_secret]
  erb :index
end
post '/weather' do
  response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?q=#{params[:location].split.join}&APPID=34f140e07bf944172a966ff9d0c0cb8f")
 p @weather = response.parsed_response["weather"].first['description']

 music_response = HTTParty.get("https://api.spotify.com/v1/artists/0TnOYISbd1XYRBk9myaseg")
 p @music = music_response.parsed_response["external_urls"].first[1]
 uri = URI(@music)
@site = Net::HTTP.get(uri)

  erb :index
end

get 'https://api.spotify.com/v1/albums/{id}' do
  # @grant_type = "authorization_code"
  # @code = params[:code]
  # @redirect_uri = 'http://localhost:9393/callback'
  # @client_id = params[:client_id]
  # @client_secret = params[:client_secret]
  content_type :json
  {name: name}.to_json
  erb :album
end


