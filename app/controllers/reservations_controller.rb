class ReservationsController < ApplicationController
  before_filter :load_restaurant

  def show
  	@reservation = Reservation.find("id = ?", params[:id])
  end

  def create
  	@reservation = @restaurant.reservations.build(reservation_params)
  	@reservation.user = current_user

    DateTime.new()

    date_params = []
    5.times do |i|
      i += 1
      date_params.push(params[:reservation]["time(" + i.to_s + "i)"].to_i)
    end

    submitted_datetime = DateTime.new(date_params[0], date_params[1], date_params[2], date_params[3], date_params[4])
    if (submitted_datetime > DateTime.now) && (submitted_datetime < 31.days.from_now)
      @seats_booked = @restaurant.reservations.where(time: submitted_datetime).sum("party_size")

      submitted_party_size = (params[:reservation][:party_size]).to_i

      if (@seats_booked + submitted_party_size) > 100
        seats_available = (100 - @seats_booked)
        flash[:alert] = "#{seats_available} seats are available for this time"
        redirect_to restaurant_path(@restaurant)
      else
        if @reservation.save
          redirect_to restaurant_path(@restaurant), notice: 'Reservation is booked!'
        else
          redirect_to restaurant_path(@restaurant)
        end
      end
    else
       flash[:alert] = "Please choose a date and time between today and 10 days from now"
      redirect_to restaurant_path(@restaurant)
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
