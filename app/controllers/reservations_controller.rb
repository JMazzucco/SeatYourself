class ReservationsController < ApplicationController
  before_filter :load_restaurant
  before_filter :ensure_logged_in, only: [:create, :destroy]

  def show
  	@reservation = Reservation.find(params[:id])
  end

  def create
  	@reservation = @restaurant.reservations.build(reservation_params)
  	@reservation.user = current_user

  	if @reservation.save
  		redirect_to restaurant_path(@restaurant), notice: 'Reservation is booked!'
  	else
  		render 'restaurant/show'
  	end
  end

  def destroy
  	@reservation = Reservation.find(params[:id])
  	@reservation.destroy
  end

private
	def reservation_params
		params.require(:reservation).permit(:time, :party_size, :restaurant_id)
	end

	def load_restaurant
		@restaurant = Restaurant.find(params[:restaurant_id])
	end
end
