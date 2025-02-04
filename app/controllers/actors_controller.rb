class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def create
    input_name = params.fetch("the_name")
    input_dob = params.fetch("the_dob")
    input_image = params.fetch("the_image")
    input_bio = params.fetch("the_bio")

    new_actor = Actor.new
    new_actor.name = input_name
    new_actor.dob = input_dob
    new_actor.image = input_image
    new_actor.bio = input_bio
    new_actor.save
    redirect_to("/actors")
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_actors = Actor.where({ :id => the_id })
    the_actor = matching_actors.at(0)
    the_actor.destroy
    redirect_to("/actors")
  end

  def update
    the_id = params.fetch("the_id")
    input_bio = params.fetch("the_bio")
    input_name = params.fetch("the_name")
    input_dob = params.fetch("the_dob")
    input_image = params.fetch("the_image")

    matching_actors = Actor.where({ :id => the_id })
    the_actor = matching_actors.at(0)
    the_actor.name = input_name
    the_actor.dob = input_dob
    the_actor.image = input_image
    the_actor.bio = input_bio
    the_actor.save
    redirect_to("/actors/#{the_actor.id}")
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
