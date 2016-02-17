require "spec_helper"

describe ProductionOrdersController do
  describe "routing" do

    it "routes to #index" do
      get("/production_orders").should route_to("production_orders#index")
    end

    it "routes to #new" do
      get("/production_orders/new").should route_to("production_orders#new")
    end

    it "routes to #show" do
      get("/production_orders/1").should route_to("production_orders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/production_orders/1/edit").should route_to("production_orders#edit", :id => "1")
    end

    it "routes to #create" do
      post("/production_orders").should route_to("production_orders#create")
    end

    it "routes to #update" do
      put("/production_orders/1").should route_to("production_orders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/production_orders/1").should route_to("production_orders#destroy", :id => "1")
    end

  end
end
