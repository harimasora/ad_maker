class Api::CitiesController < ApplicationController
  def index
    uf = ''

    unless params[:filterrific].blank?
      unless params[:filterrific][:with_federation_unit_id].blank?
        uf = params[:filterrific][:with_federation_unit_id]
      end
    end

    unless params[:production_order].blank?
      unless params[:production_order][:federation_unit_id].blank?
        uf = params[:production_order][:federation_unit_id]
      end
    end

    if uf.blank?
      @cities = []
    else
      @cities = Api::City.select_formatted(uf)
    end
    render :json => @cities
  end
end