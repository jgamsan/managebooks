class WelcomeController < ApplicationController
  layout 'application'
  def index
    @categorias = Category.all
    @stores = Store.last_stores
    @provincias = Province.all
    @json = asignar_icono
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

  private
  def asignar_icono
    @stores = Store.all.map {|x| x.id}.shuffle
    @stores_free = Store.free_resorts.map {|x| x.id}.shuffle
    @stores_by_icon = []
    @stores.each do |store|
      @tienda = Store.find(store)
      if @stores_free.include?(store)
        @stores_by_icon << {description: Store.infowindow(store), title: @tienda.name.capitalize, lng: @tienda.longitude, lat: @tienda.latitude, picture: "/images/map_pin_alt_16x32_green.png", width: "16", height: "32"}
      else
        @stores_by_icon << {description: Store.infowindow(store),title: @tienda.name.capitalize, lng: @tienda.longitude, lat: @tienda.latitude, picture: "/images/map_pin_alt_16x32_red.png", width: "16", height: "32"}
      end
    end
    @stores_by_icon.to_json
  end

end

