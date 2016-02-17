class Api::FederationUnitsController < ApplicationController
  def index
    @federation_units = Api::FederationUnit.raw
  end
end