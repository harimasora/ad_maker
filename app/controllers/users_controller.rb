class UsersController < ApplicationController
  def index
    if params[:filterrific][:with_business_unit_id].empty?
      @users = []
    else
      @users = User.options_for_responsible_select(params[:filterrific][:with_business_unit_id])
    end
    render :json => @users
  end
end