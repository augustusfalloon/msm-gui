class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def create
    input_title = params.fetch("the_title")
    input_year = params.fetch("the_year")
    input_duration = params.fetch("the_duration")
    input_description = params.fetch("the_description")
    input_image = params.fetch("the_image")
    input_director_id = params.fetch("the_director_id")

    new_movie = Movie.new
    new_movie.title = input_title
    new_movie.year = input_year
    new_movie.duration = input_duration
    new_movie.description = input_description
    new_movie.image = input_image
    new_movie.director_id = input_director_id

    
    new_movie.save
    redirect_to("/movies")
  
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_movies = Movie.where({ :id => the_id })
    the_movie = matching_movies.at(0)
    the_movie.destroy
    redirect_to("/movies")
  end

  def update
    the_id = params.fetch("the_id")
    input_title = params.fetch("the_title")
    input_year = params.fetch("the_year")
    input_duration = params.fetch("the_duration")
    input_description = params.fetch("the_description")
    input_image = params.fetch("the_image")
    input_director_id = params.fetch("the_director_id")

    matching_movies = Movie.where({ :id => the_id })
    the_movie = matching_movies.at(0)

    the_movie.title = input_title
    the_movie.year = input_year
    the_movie.duration = input_duration
    the_movie.description = input_description
    the_movie.image = input_image
    the_movie.director_id = input_director_id

    
    the_movie.save
    redirect_to("/movies/#{the_movie.id}")
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
