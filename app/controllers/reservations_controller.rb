class ReservationsController < ApplicationController
  before_filter :load_restaurant

  def new
    @reservation = Reservation.new

    #An array of hours open
    # @hours_open = (11..23).to_a
    # #iterate through each hour and only keep it if the sum of the party size of the selected hour is under 100
    # unless @restaurant.reservations.size <= 1
    #   @hours_open.keep_if do |timeslot|
    #     @restaurant.reservations.where(time: timeslot).sum("party_size") < 100 || @restaurant.reservations.where(time: timeslot).sum("party_size") == nil
    #   end
    # end
  end

  def create
    date_params = []
    5.times do |i|
      i += 1
      date_params.push(params[:reso]["datetime(" + i.to_s + "i)"].to_i)
    end

    submitted_time = Time.new(date_params[0],date_params[1],date_params[2],date_params[3], date_params[4])

    #user must select a time from now to 31 days from now
    if (submitted_time > Time.now) && (submitted_time < Time.at(2678400 + Time.now.to_i))
      @seats_booked = @restaurant.reservations.where(time: submitted_time).sum("party_size")
      submitted_party_size = (params[:party_size]).to_i
      @reservation = @restaurant.reservations.build(party_size: params["party_size"], time: submitted_time)
      @reservation.user = current_user
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
      flash[:alert] = "Please choose a date between today and 31 days from now"
      redirect_to restaurant_path(@restaurant)
    end
  end

  def show
    #@reservations = current_user.reservations.where(restaurant_id: @restaurant.id)
  end

  def destroy
  	@reservation = Reservation.find(params[:id])
  	@reservation.destroy
    redirect_to restaurant_path(@restaurant)
  end

private
	def reservation_params
		params.require(:reso).permit(:datetime, :party_size, :restaurant_id)
	end

	def load_restaurant
		@restaurant = Restaurant.find(params[:restaurant_id])
	end
end
