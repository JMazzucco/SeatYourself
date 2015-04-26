class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])

    if current_user
        @reservation = @restaurant.reservations.build
        reservation_times
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
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_url
  end


  def reservation_times
      @available_times = (11..23).to_a
    @available_times.each do |timeslot|
      if Reservation.where(time: timeslot).count > 0
        @available_times.delete(timeslot)
      end
    end
    @available_times
  end

  def max_capacity
    Reservation.sum("party_size")
  end

private
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :cuisine_type, :website)
  end
end
