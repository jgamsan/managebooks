class Admin::BooksController < Admin::BaseController
  
  def index
   @books = Book.page params[:page]
   respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @books }
      format.js
    end
  end

  def para_hoy
    @books = Book.hoy.page params[:page]
    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end
  
  def tomorrow
    @books = Book.tomorrow.page params[:page]
    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end
end

