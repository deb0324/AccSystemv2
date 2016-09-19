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
    @raw_type = params[:type]
    @tasks = []
    @check_types = get_check_types()

    session[:session_url] = request.original_url
    
    #set sort flag if sort button is pressed
    if params[:sort]
      set_sort(true)
    end


    if current_user.accountant?
      customers = Customer.where(status: "current").order(:leader_id).order(:manager_id).order(:officer_id).order(:code)
    
    elsif current_user.moved?
      customers = Customer.where(status: "moved").order(:leader_id).order(:manager_id).order(:officer_id).order(:code)

    elsif current_user.closed?
      customers = Customer.where(status: "closed").order(:leader_id).order(:manager_id).order(:officer_id).order(:code)

    else
      types = ["officer", "leader", "manager"]
      types.each do |type|
        customers = is_responsible(params[:id], type)

        @tasks = []
        customers.each do |customer|
          @tasks.concat(customer.tasks.where(year: params[:year]))
        end

        #sort list of sort is true
        if get_sort
          @tasks = sort_checks(@tasks)
        end

        case type
        when "officer"
          @officer_tasks = @tasks
        when "leader"
          @leader_tasks = @tasks
        else
          @manager_tasks = @tasks
        end
      end
    end

    if current_user.accountant? || current_user.moved? || current_user.closed?
      customers.each do |customer|
        @tasks.concat(customer.tasks.where(year: params[:year]))
        if get_sort
          @tasks = sort_checks(@tasks)
        end
      end
    end

  def destroy
    session[:user_id] = nil
    set_sort(false)
    
    flash[:success] = '已登出'
    redirect_to root_path
  end

  end

  private

  def sort_checks(tasks)
    tasks.sort_by{|x| Check.find(x.read_attribute(@raw_type)).total_checks}
  end


  # Get all the customers that the user is involved in depending on user type
  def is_responsible_sort(id, type)
    case type
    when "officer"
      sort_checks(Customer.where(officer_id: id, status: "current").order(:leader_id).order(:code))
    when "leader"
      sort_checks(Customer.where(leader_id: id, status: "current").order(:officer_id).order(:code)) - Customer.where(officer_id: id, status: "current").order(:officer_id).order(:code)
    when "manager"
      Customer.where(manager_id: id, status: "current").order(:leader_id).order(:officer_id).order(:code) - Customer.where(leader_id: id, status: "current").order(:leader_id).order(:officer_id).order(:code) - Customer.where(officer_id: id, status: "current").order(:leader_id).order(:officer_id).order(:code)
    else

    end
  end

  def is_responsible(id, type)
    case type
    when "officer"
      Customer.where(officer_id: id, status: "current").order(:leader_id).order(:code)
    when "leader"
      Customer.where(leader_id: id, status: "current").order(:officer_id).order(:code) - Customer.where(officer_id: id, status: "current").order(:officer_id).order(:code)
    when "manager"
      Customer.where(manager_id: id, status: "current").order(:leader_id).order(:officer_id).order(:code) - Customer.where(leader_id: id, status: "current").order(:leader_id).order(:officer_id).order(:code) - Customer.where(officer_id: id, status: "current").order(:leader_id).order(:officer_id).order(:code)
    else

    end
  end
end