class RestaurantsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]

  def index
    if params[:search]
      @restaurants = Restaurant.near(params[:search], 10, units: :km)
    elsif params[:longitude] && params[:latitude]
      @restaurants = Restaurant.near([params[:latitude], params[:longitude]], 10, units: :km)
    else
      @restaurants = Restaurant.all
    end

      @results_count = @restaurants.size

    respond_to do |f|
      f.html
      f.js
    end
  end

  def show
    #the record of the current restaurant
    @restaurant = Restaurant.find(params[:id])
    @nearby_restaurants = @restaurant.nearbys(10, units: :km)

    if current_user
      @reservation = @restaurant.reservations.build
      @reservations = current_user.reservations.where(restaurant_id: @restaurant.id)
    end

  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    appended_params = restaurant_params
    appended_params[:address] = "#{restaurant_params[:street]}, #{restaurant_params[:city]}, #{restaurant_params[:prov]}, #{restaurant_params[:postal]}"

    @restaurant = Restaurant.new(appended_params)

    if @restaurant.save
      redirect_to restaurants_url
    else
      render :new
    end
  end

  def edit
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to new_session_path
    end
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    if @restaurant.update_attributes(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      render :edit
    end
  end

  def destroy
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to new_session_path
    end
      @restaurant = Restaurant.find(params[:id])
      @restaurant.destroy
      redirect_to restaurants_url
  end

private
  def restaurant_params
    params.require(:restaurant).permit(:image, :name, :street, :city, :prov, :postal, :cuisine_type, :website, :owner, :description)
  end
end
