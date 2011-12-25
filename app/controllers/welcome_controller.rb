class WelcomeController < ApplicationController
  layout 'application'
  def index
    @categorias = Category.all
    @stores = Store.last_stores
    @provincias = Province.all
    @json = Store.all.to_gmaps4rails
  end

  def bycategory
    @stores = Store.category(params[:id])

    @category = Category.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def bystore
    @resorts = Resort.store(params[:id])
    @store = Store.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

end

