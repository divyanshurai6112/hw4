class PlacesController < ApplicationController

  def index
    @places = Place.all.order("name")
    @current_user = User.find_by({ "id" => session["user_id"] })
    render("places/index")
  end

  def show
    @place = Place.find(params["id"])
    @current_user = User.find_by({ "id" => session["user_id"] })
    if @current_user.present?
      @entries = Entry.where({ "place_id" => @place.id, "user_id" => @current_user["id"] }).order("occurred_on")
    else
      @entries = []
    end
    render("places/show")
  end

  def new
    render("places/new")
  end

  def create
    place = Place.new
    place["name"] = params["name"]
    place.save
    redirect_to("/places")
  end

end