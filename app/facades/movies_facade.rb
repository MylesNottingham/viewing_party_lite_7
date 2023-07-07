class MoviesFacade
  def initialize(search = nil)
    @search = search
  end

  def movies
    service = MovieService.new

    json = @search ? service.search_movies(@search) : service.top_rated_movies

    @movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end
