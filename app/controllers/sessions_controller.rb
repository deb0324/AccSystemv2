class SessionsController < ApplicationController

  def new
    @type_options = get_task_types_chin()
    @year_options = get_years()
    @names = name_array()
  end

  def create

    @user = User.find_by_name(params[:session][:name].split(" ")[1])

    type = task_c2e(params[:session][:type])
    year = params[:session][:year].to_i

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to session_path(@user, year: year, type: type)
    else
      flash[:error] = "請確定資料都正確(姓名,密碼)"
      redirect_to new_session_path
    end
  end

  def show
    @user = User.find(params[:id])
    @year = params[:year]
    @query = "#{@user.name} > #{params[:year]}年 > #{task_e2c(params[:type])}"
    @tasks = []
    customers = Customer.all
    customers.each do |customer|
      @tasks.concat(customer.tasks.where(year: params[:year]))
    end
  end

end