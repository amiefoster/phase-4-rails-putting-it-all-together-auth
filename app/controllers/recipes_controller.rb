class RecipesController < ApplicationController

    def index
        recipes = Recipe.all
        if session[:user_id]
            render json: recipes
        else
            render json: {errors: ["You must be logged in to access this content"] }, status: :unauthorized
        end
    end

    def create
        if session[:user_id]
            new_recipe = Recipe.create!(recipe_params)
            render json: new_recipe, status: :created
        else
            render json: {errors: ["You must be logged in to access this content"] }, status: :unauthorized
        end

    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

end

