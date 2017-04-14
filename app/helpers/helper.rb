helpers do
  def get_weather(city)
    JSON.load(open())
  end
end
