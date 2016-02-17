class Api::GrouosController < ApplicationController
  def index
    @groups = Api::Group.raw
  end
end