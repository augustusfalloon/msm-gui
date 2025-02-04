class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def create
    input_name = params.fetch("the_name")
    input_dob = params.fetch("the_dob")
    input_image = params.fetch("the_image")
    input_bio = params.fetch("the_bio")
    
    new_director = Director.new
    new_director.name = input_name
    new_director.dob = input_dob
    new_director.image = input_image
    new_director.bio = input_bio
    new_director.save
    redirect_to("/directors")
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_directors = Director.where({ :id => the_id })
    the_director = matching_directors.at(0)
    the_director.destroy
    redirect_to("/directors")
  end

  def update
    the_id = params.fetch("the_id")
    input_bio = params.fetch("the_bio")
    input_name = params.fetch("the_name")
    input_dob = params.fetch("the_dob")
    input_image = params.fetch("the_image")
    matching_directors = Director.where({ :id => the_id })
    the_director = matching_directors.at(0)
    the_director.name = input_name
    the_director.dob = input_dob
    the_director.image = input_image
    the_director.bio = input_bio
    the_director.save
    redirect_to("/directors/#{the_director.id}")
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
