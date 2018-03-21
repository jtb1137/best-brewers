class ReviewsController < ApplicationController
    before_action :set_brewery

    def create
        @review = @brewery.reviews.build(review_params)
        @review.user_id = current_user.id

        if @review.save
            flash[:success] = "Review Submitted"
            redirect_to brewery_path(@brewery)
        else
            flash[:alert] = "Review Failed"
            render root_path
        end
    end

    def destroy
        @review = @brewery.reviews.find(params[:id])
        @review.destroy
        flash[:success] = "Review Deleted"
        redirect_to root_path
    end

    private

    def review_params
        params.require(:review).permit(:rating, :content)
    end

    def set_brewery
        @brewery = Brewery.find(params[:brewery_id])
    end
end

