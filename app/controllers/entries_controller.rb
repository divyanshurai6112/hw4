class EntriesController < ApplicationController

  def new
    @place = Place.find(params["place_id"])
    @current_user = User.find_by({ "id" => session["user_id"] })
    if @current_user.present?
      render("entries/new")
    else
      redirect_to("/login")
    end
  end

  def create
    entry = Entry.new
    entry["title"]       = params["title"]
    entry["description"] = params["description"]
    entry["occurred_on"] = params["occurred_on"]
    entry["place_id"]    = params["place_id"]
    entry["user_id"]     = session["user_id"]
    entry.save
    redirect_to("/places/#{params["place_id"]}")
  end

end