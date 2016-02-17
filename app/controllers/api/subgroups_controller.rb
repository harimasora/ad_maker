class Api::SubgroupsController < ApplicationController
  # -----------------------
  # | GAMBIARRA ALERT!!!! |
  # -----------------------
  def index
    if params[:production_order][:category1].nil? && params[:production_order][:category2].nil? && params[:production_order][:category3].nil?
      @subgroups = []
    else
      if !params[:production_order][:category1].nil?
        @subgroups = Api::Subgroup.select_formatted(params[:production_order][:category1])
      elsif !params[:production_order][:category2].nil?
        @subgroups = Api::Subgroup.select_formatted(params[:production_order][:category2])
      else
        @subgroups = Api::Subgroup.select_formatted(params[:production_order][:category3])
      end

    end
    render :json => @subgroups
  end
end