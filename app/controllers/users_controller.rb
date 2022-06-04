class UsersController < ApplicationController
  def show
    @user = GearUpFacade.find_user(params[:id])
    @items = GearUpFacade.items(params[:id])[0..2]
    @trips = GearUpFacade.user_trips(params[:id]).sort_by{|trip| trip.start_date}[0..1]
#     sandisz ^ 
    @user = UserFacade.user(session[:user_id])
  end
  
  def index
    @users = GearUpFacade.users
  end

  def create
    auth_hash = request.env['omniauth.auth']
    session[:access_token] = auth_hash[:credentials][:token]
    user = UserFacade.create_user(auth_hash[:info])

    redirect_to "/login?user_id=#{user.id}"
  end
end
