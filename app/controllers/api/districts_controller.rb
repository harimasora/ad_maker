class Api::DistrictsController < ApplicationController
  def index
    city = ''

    unless params[:production_order].blank?
      unless params[:production_order][:city_id].blank?
        city = params[:production_order][:city_id]
      end
    end

    if city.blank?
      @districts = []
    else
      @districts = Api::District.select_formatted(city)
    end
    render :json => @districts
  end
end