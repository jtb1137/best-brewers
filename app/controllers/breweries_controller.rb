class BreweriesController < ApplicationController
    before_action :set_brewery, only: [:show, :edit, :update, :destroy, :favorite]
    skip_before_action :authenticate_user!, only: [:index, :show]

    def index
        # visitor_location = request.location.city
        @breweries = Brewery.all
    end

    def new
        @brewery = Brewery.new
        @categories = 3.times.collect { @brewery.categories.build }
    end

    def create
        @brewery = Brewery.new(brewery_params)
        @brewery.submitted_by = current_user.id

        if @brewery.save
            redirect_to brewery_path(@brewery)
        else
            render 'new'
        end
    end

    def show
        @favorite = Favoritebrewery.find_by(user: current_user, brewery: @brewery).present?
        @submitted = User.find(@brewery.submitted_by)
    end

    def edit
        @categories = 3.times.collect { @brewery.categories.build }
    end

    def update
        if @brewery.update(brewery_params)
            redirect_to brewery_path(@brewery)
        else
            render 'new'
        end
    end

    def destroy
        @brewery.destroy
        redirect_to root_path
    end

    def favorite
        button = params[:button]
        if button == "favorite"
            current_user.favorites << @brewery
            redirect_to brewery_path(@brewery)
        elsif button == "unfavorite"
            current_user.favorites.destroy(@brewery)
            redirect_to brewery_path(@brewery)
        end
    end

    def search
        @breweries = Brewery.search(params)
    end

    private
    def set_brewery
        @brewery = Brewery.find(params[:id])
    end

    def brewery_params
        params.require(:brewery).permit(:name, :address1, :address2, :city, :state, :zipcode, :location, :search,
            :image, :submitted_by, category_ids:[], categories_attributes: [ :id, :name ])
    end

end
