class ReservationsController < ApplicationController
  before_filter :load_restaurant

  def show
  	@reservation = Reservation.find(params[:id])
  end

  def create
  	@reservation = @restaurant.reservations.build(reservation_params)
  	@reservation.user = current_user

    requested_time = (params[:reservation][:time]).to_i
    @seats_booked = @restaurant.reservations.where(time: requested_time).sum("party_size")

    requested_party = (params[:reservation][:party_size]).to_i

        if (@seats_booked + requested_party) > 100
          seats_available = (100 - @seats_booked)
          #alert does not display at next HTTP response
          flash[:alert] = "Limited seats available. Please choose a party size of #{seats_available} or smaller"
          redirect_to restaurant_path(@restaurant)
        else
          if @reservation.save
        		redirect_to restaurant_path(@restaurant), notice: 'Reservation is booked!'
        	else
        		redirect_to restaurant_path(@restaurant)
        	end
        end
  end

  def destroy
  	@reservation = Reservation.find(params[:id])
  	@reservation.destroy
    redirect_to restaurant_path(@restaurant)
  end

private
	def reservation_params
		params.require(:reservation).permit(:time, :party_size, :restaurant_id)
	end

	def load_restaurant
		@restaurant = Restaurant.find(params[:restaurant_id])
	end
end
