class BusinessUnitsController < ApplicationController
  def index
    if params[:filterrific][:with_city_id].empty?
      @business_units = []
    else
      @business_units = BusinessUnit.options_for_select(params[:filterrific][:with_city_id])
    end
    render :json => @business_units
  end
end