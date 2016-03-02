class Api::SubgroupsController < ApplicationController
  def index

    if params.fetch(:category, {}).fetch(:api_id, {}).blank?
      if params.fetch(:production_order, {}).fetch(:categories_attributes, {}).blank?
        @subgroups = []
      else
        select_field_hash = params[:production_order][:categories_attributes]
        keys = select_field_hash.keys
        select_field = select_field_hash[keys.first]
        api_id = select_field[:api_id]
        @subgroups = Api::Subgroup.select_formatted(api_id)
      end
    else
      @subgroups = Api::Subgroup.select_formatted(params[:category][:api_id])
    end

    render :json => @subgroups
  end
end