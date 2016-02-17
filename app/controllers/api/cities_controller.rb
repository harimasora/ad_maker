class Api::CitiesController < ApplicationController
  def index
    if params[:filterrific][:with_federation_unit_id].empty?
      @cities = []
    else
      @cities = Api::City.select_formatted(params[:filterrific][:with_federation_unit_id])
    end
    render :json => @cities
  end
end