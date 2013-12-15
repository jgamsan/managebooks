class StoresController < ApplicationController
  def list_available
    @stores = Store.all

    respond_to do |format|
      format.json { render :json => @stores.to_json }
    end
  end
end
