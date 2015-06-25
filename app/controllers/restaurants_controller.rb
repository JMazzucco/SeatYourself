class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def show
    #the record of the current restaurant
    @restaurant = Restaurant.find(params[:id])

    #An array of hours open
    @hours_open = (11..23).to_a

    #iterate through each hour and only keep it if the sum of the party size of the selected hour is under 100
    @hours_open.keep_if do |timeslot|
      @restaurant.reservations.where(time: timeslot).sum("party_size") < 100 || @restaurant.reservations.where(time: timeslot).sum("party_size") == nil
    end

    if current_user
        @reservation = @restaurant.reservations.build
    end


  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
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
    unless current_userflash[:alert] = "Please log in"
      redirect_to new_session_path
    end
      @restaurant = Restaurant.find(params[:id])
      @restaurant.destroy
      redirect_to restaurants_url
  end

private
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :cuisine_type, :website)
  end
end
