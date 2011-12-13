class BooksController < ApplicationController
  def daily
    @intervals = Interval.byresort(params[:id])
    respond_to do |format|
      format.js
    end
  end
end
