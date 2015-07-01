class ReviewsController < ApplicationController
  before_filter :load_restaurant

  def index
  	@reviews= Review.all
  end

  def new
  	@review = Review.new
  end

  def create
  	@review = @restaurant.reviews.build(review_params)
  	@review.user = current_user

		if @review.save
      redirect_to(restaurants_url, notice: 'Review was successfully created')
  	else
      flash[:success] = "flash[:alert]"
  		render "new"
  	end
  end

private
	def review_params
		 params.require(:review).permit(:comment, :rating)
		# review[:restaurant_id] = params[:restaurant_id]
		# review
	end

	def load_restaurant
		@restaurant = Restaurant.find(params[:restaurant_id])
	end
end
