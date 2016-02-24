class ProductionOrdersController < ApplicationController
  before_action :set_production_order, only: [:show, :edit, :update, :destroy, :approve]
  before_action :set_api_data, only: [:show, :new, :edit]
  before_action :set_user_and_business_unit
  load_and_authorize_resource

  # GET /production_orders
  # GET /production_orders.json
  def index
    @federation_unit_blank = federation_unit_blank
    @federation_unit_options = federation_unit_options
    @city_blank = city_blank
    @city_options = city_options
    @business_unit_blank = business_unit_blank
    @business_unit_options = business_unit_options

    # Initialize filterrific with the following params:
    # * `Student` is the ActiveRecord based model class.
    # * `params[:filterrific]` are any params submitted via web request.
    #   If they are blank, filterrific will try params persisted in the session
    #   next. If those are blank, too, filterrific will use the model's default
    #   filter settings.
    # * Options:
    #     * select_options: You can store any options for `<select>` inputs in
    #       the filterrific form here. In this example, the `#options_for_...`
    #       methods return arrays that can be passed as options to `f.select`
    #       These methods are defined in the model.
    #     * persistence_id: optional, defaults to "<controller>#<action>" string
    #       to isolate session persistence of multiple filterrific instances.
    #       Override this to share session persisted filter params between
    #       multiple filterrific instances. Set to `false` to disable session
    #       persistence.
    #     * default_filter_params: optional, to override model defaults
    #     * available_filters: optional, to further restrict which filters are
    #       in this filterrific instance.
    # This method also persists the params in the session and handles resetting
    # the filterrific params.
    # In order for reset_filterrific to work, it's important that you add the
    # `or return` bit after the call to `initialize_filterrific`. Otherwise the
    # redirect will not work.

    @filterrific = initialize_filterrific(
        ProductionOrder.accessible_by(current_ability).joins(:soliciting_user).select('production_orders.*, users.email as soliciting_user_email'),
        params[:filterrific],
        select_options: {
            sorted_by: ProductionOrder.options_for_sorted_by,
            with_federation_unit_id: ProductionOrder.options_for_with_federation_unit_id(@user, @business_unit),
            with_city_id: ProductionOrder.options_for_with_city_id(@user, @business_unit),
            with_business_unit_id: ProductionOrder.options_for_with_business_unit_id(@user, @business_unit),
            with_state: CodeItem.options_for_process_state_select,
            with_soliciting_user_id: User.options_for_select,
            with_responsible_user_id: ProductionOrder.options_for_with_responsible_user_id(@business_unit)
        },
        persistence_id: false,
        # default_filter_params: {},
        # available_filters: [],
    ) or return

    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    @production_orders = @filterrific.find.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end

  # Recover from invalid param sets, e.g., when a filter refers to the
  # database id of a record that doesn’t exist any more.
  # In this case we reset filterrific and discard all filter params.
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /production_orders/1
  # GET /production_orders/1.json
  def show
  end

  # GET /production_orders/new
  def new
    @production_order = ProductionOrder.new
  end

  # GET /production_orders/1/edit
  def edit
    @production_order.rejection_reasons.build
    @cities = []
    @districts = []
    unless @production_order.federation_unit_id.nil?
      @cities = Api::City.select_formatted(@production_order.federation_unit_id)
    end
    unless @production_order.city_id.nil?
      @districts = Api::District.select_formatted(@production_order.city_id)
    end
  end

  # POST /production_orders
  # POST /production_orders.json
  def create
    @production_order = ProductionOrder.new(production_order_params)
    bid = @business_unit.id
    uid = @user.id
    @production_order.business_unit_id = bid
    @production_order.soliciting_user_id = uid

    respond_to do |format|
      if @production_order.save
        format.html { redirect_to @production_order, notice: 'Production order was successfully created.' }
        format.json { render :show, status: :created, location: @production_order }
      else
        format.html { render :new }
        format.json { render json: @production_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /production_orders/1
  # PATCH/PUT /production_orders/1.json
  def update
    respond_to do |format|
      if @production_order.update(production_order_params)
        format.html { redirect_to @production_order, notice: 'Production order was successfully updated.' }
        format.json { render :show, status: :ok, location: @production_order }
      else
        format.html { render :edit }
        format.json { render json: @production_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /production_orders/1
  # DELETE /production_orders/1.json
  def destroy
    @production_order.destroy
    respond_to do |format|
      format.html { redirect_to production_orders_url, notice: 'Production order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve
    @production_order.approve
    update
  end

  def cancel
    @production_order.cancel
    update
  end

  def check_design
    @production_order.check_design
    update
  end

  def reject
    @production_order.reject
    update
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_production_order
      @production_order = ProductionOrder.find(params[:id])
    end

    def set_api_data
      @categories = Api::Group.select_formatted
      @federation_units = Api::FederationUnit.select_formatted
    end

    def set_user_and_business_unit
      @user = current_user
      @business_unit = @user.business_unit
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def production_order_params
      params.require(:production_order).permit(:business_unit_id,
                                               :soliciting_user_id,
                                               :responsible_user_id,
                                               :federation_unit_id,
                                               :federation_unit_name,
                                               :city_id,
                                               :city_name,
                                               :district_id,
                                               :district_name,
                                               :address,
                                               :category1,
                                               :category2,
                                               :category3,
                                               :code,
                                               :contact_email,
                                               :contact_name,
                                               :contact_phone,
                                               :description,
                                               :email,
                                               :facebook,
                                               :keywords,
                                               :logotype,
                                               :logotype_cache,
                                               :remove_logotype,
                                               :name,
                                               :phone1,
                                               :phone2,
                                               :phone3,
                                               :publicity_text,
                                               :state,
                                               :subcategory1,
                                               :subcategory2,
                                               :subcategory3,
                                               :website,
                                               :youtube_video,
                                               :zip,
                                               rejection_reasons_attributes: [:id, :description],
                                               banners_attributes: [:id, :image, :image_cache, :description, :keywords, :kind, :rank, :state,  :_destroy],
                                               categories_attributes: [:id, :name, :api_id, :subcategory_name, :subcategory_api_id, :_destroy],
                                               attachments_attributes: [:id, :attachment, :attachment_cache, :description, :rank, :state, :_destroy])
    end

    def federation_unit_blank
      if @user.admin?
        { include_blank: '- Todos -'}
      else
        { }
      end
    end

    def federation_unit_options
      if @user.admin?
        {
            :'data-remote' => 'true', # important for UJS
            :'data-url' => url_for(:controller => 'api/cities', :action => 'index'), # we get the data from here!
            :'data-type' => 'json', # tell jQuery to parse the response as JSON!
            class: 'form-control'
        }
      else
        {
            class: 'form-control',
            disabled: true
        }
      end
    end

    def city_blank
      if @user.admin? || @user.master?
        { include_blank: '- Todos -'}
      else
        { }
      end
    end

    def city_options
      if @user.admin? || @user.master?
        {
            :'data-remote' => 'true',
            :'data-url' => url_for(:controller => 'business_units', :action => 'index'),
            :'data-type' => 'json',
            class: 'form-control'
        }
      else
        {
            class: 'form-control',
            disabled: true
        }
      end
    end

    def business_unit_blank
      if @user.admin? || @user.master? || @user.franchisee?
        { include_blank: '- Todos -'}
      else
        { }
      end
    end

    def business_unit_options
      if @user.admin? || @user.master? || @user.franchisee?
        {
            :'data-remote' => 'true',
            :'data-url' => url_for(:controller => 'users', :action => 'index'),
            :'data-type' => 'json',
            class: 'form-control'
        }
      else
        {
            class: 'form-control',
            disabled: true
        }
      end
    end

end
