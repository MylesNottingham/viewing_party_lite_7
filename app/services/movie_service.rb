class MovieService
  def top_rated_movies
    get_url("movie/top_rated")
  end

  def search_movies(search)
    get_url("search/movie?query=#{search}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.themoviedb.org/3/") do |faraday|
      faraday.params["api_key"] = ENV["MOVIE_API_KEY"]
    end
  end
end
