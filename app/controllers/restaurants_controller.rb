class RestaurantsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]

  def index
    if params[:search]
      @restaurants = Restaurant.near(params[:search], 1, units: :km)
    elsif params[:longitude] && params[:latitude]
      @restaurants = Restaurant.near([params[:latitude], [:longitude]], 1, units: :km)
    else
      @restaurants = Restaurant.all
    end

    respond_to do |f|
      f.html
      f.js
    end
  end

  def show
    #the record of the current restaurant
    @restaurant = Restaurant.find(params[:id])
    @reservation = @restaurant.reservations.build
    @nearby_restaurants = @restaurant.nearbys(10, units: :km)

    #An array of hours open
    @hours_open = (11..23).to_a

    #iterate through each hour and only keep it if the sum of the party size of the selected hour is under 100
    @hours_open.keep_if do |timeslot|
      @restaurant.reservations.where(time: timeslot).sum("party_size") < 100 || @restaurant.reservations.where(time: timeslot).sum("party_size") == nil
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


    # address = restaurant_params[street]
    # binding.pry
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
    params.require(:restaurant).permit(:image, :name, :street, :city, :prov, :postal, :cuisine_type, :website, :owner)
  end
end
