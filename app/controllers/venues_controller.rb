class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("an_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)

    render({ :template => "venue_templates/details" })
  end

  def create
    input_venue_name = params.fetch("query_name")
    input_venue_address = params.fetch("query_address")
    input_venue_neighborhood = params.fetch("query_neighborhood")

    a_new_venue = Venue.new
    a_new_venue.address = input_venue_address
    a_new_venue.name = input_venue_name
    a_new_venue.neighborhood = input_venue_neighborhood

    a_new_venue.save

    redirect_to("/venues/#{a_new_venue.id}")
  end
  
  def update
    the_id = params.fetch("venue_id")

    matching_venues = Venue.where({ :id => the_id })

    the_venue = matching_venues.at(0)

    input_address = params.fetch("query_address")
    input_name = params.fetch("query_name")
    input_neighborhood = params.fetch("query_neighborhood")

    the_venue.address = input_address
    the_venue.name = input_name
    the_venue.neighborhood = input_neighborhood

    the_venue.save
    
    redirect_to("/venues/#{the_venue.id}")
  end

  def destroy
    the_id = params.fetch("id_to_delete")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.at(0)
    venue.destroy

    redirect_to("/venues")
  end

end
