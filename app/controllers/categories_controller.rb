class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update]
    before_action :require_admin, except: [:show, :index]
    
    def show
        @articles = @category.articles.paginate(page: params[:page], per_page: 5)
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "Category was created successfully"
            redirect_to @category
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @category.update(category_params)
            flash[:notice] = "Category updated successfully"
            redirect_to @category
        else
            render 'edit'
        end
    end

    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end

    private
    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end

    def require_admin
        if !(logged_in? && current_user.admin?)
            flash[:alert] = "You're restricted to perform this action"
            redirect_to categories_path
        end
    end
end