class WelcomeController < ApplicationController
  layout 'application'

  def index
    @categorias = Category.all
    @stores = Store.last_stores
    @provincias = Province.all
    @json = all_stores
  end

  def bycategory
    @json = stores_by_category(params[:id])
    @category = Category.find(params[:id])
    @stores = Store.category(params[:id])
    respond_to do |format|
      format.js
      format.json { render :json => @json}
    end
  end

  def bystore
    @resorts = Resort.store(params[:id])
    @store = Store.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  private
  def stores_by_category(category)
    @stores = Store.category(category).map {|x| x.id}.shuffle
    @stores_free = Store.free_resorts_by_category(category).map {|x| x.id}.shuffle
    @stores_by_icon = []
    @stores.each do |store|
      @tienda = Store.find(store)
      if @stores_free.include?(store)
        @stores_by_icon << {description: Store.infowindow(store), title: @tienda.name.capitalize, lng: @tienda.longitude, lat: @tienda.latitude, picture: @tienda.category.icon.url, width: "16", height: "32"}
      else
        @stores_by_icon << {description: Store.infowindow(store),title: @tienda.name.capitalize, lng: @tienda.longitude, lat: @tienda.latitude, picture: @tienda.category.icon.url, width: "16", height: "32"}
      end
    end
    @stores_by_icon.to_json
  end

  def all_stores
    @stores = Store.all.map {|x| x.id}.shuffle
    @stores_free = Store.free_resorts.map {|x| x.id}.shuffle
    @stores_by_icon = []
    @stores.each do |store|
      @tienda = Store.find(store)
      if @stores_free.include?(store)
        @stores_by_icon << {description: Store.infowindow(store), title: @tienda.name.capitalize, lng: @tienda.longitude, lat: @tienda.latitude, picture: @tienda.category.icon.url, width: "16", height: "32"}
      else
        @stores_by_icon << {description: Store.infowindow(store),title: @tienda.name.capitalize, lng: @tienda.longitude, lat: @tienda.latitude, picture: @tienda.category.icon.url, width: "16", height: "32"}
      end
    end
    @stores_by_icon.to_json
  end

end

