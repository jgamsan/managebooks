class IdentitiesController < ApplicationController
  layout 'register'
  def new
    @identity = env['omniauth.identity']
  end
end
