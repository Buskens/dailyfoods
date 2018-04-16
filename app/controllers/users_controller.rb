class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    if params[:search_date] != nil
      puts "********debug*********"
      unless params[:search_date][:"datecost(1i)"].empty?
        date = Date.new(params[:search_date][:"datecost(1i)"].to_i, params[:search_date][:"datecost(2i)"].to_i, params[:search_date][:"datecost(3i)"].to_i) 
        @date = date
        @datecost = current_user.datecost(date)
      end
      unless params[:search_date][:"monthcost(1i)"].empty?
        month = Date.new(params[:search_date][:"monthcost(1i)"].to_i, params[:search_date][:"monthcost(2i)"].to_i, 1)
        @month = month
        @monthcost = current_user.monthcost(month)
      end
      unless params[:search_date][:"yearcost(1i)"].empty?
        year = Date.new(params[:search_date][:"yearcost(1i)"].to_i, 1, 1)
        @year = year
        @yearcost = current_user.yearcost(year)
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました'
      render :new
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
    
end
