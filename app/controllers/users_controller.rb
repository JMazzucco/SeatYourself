class UsersController < ApplicationController
  def new
  		@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "Welcome to SeatYourself!"
  		redirect_to restaurants_url, notice: "Signed up!"
  	else
      flash[:success] = "flash[:alert]"
  		render "new"
  	end
  end

private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :time_zone)
	end
end
