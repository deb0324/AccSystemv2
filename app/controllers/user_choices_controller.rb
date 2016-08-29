class UserChoicesController < ApplicationController
  def new
    @users = name_array()
  end

  def create
    @user = User.find_by_name(params[:session][:name].split(" ")[1])

    if @user
      redirect_to edit_user_path(@user)
    else 
      render :new
    end
  end
end