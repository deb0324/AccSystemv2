class TasksController < ApplicationController

  def check
    check = Check.find(Task.find(params[:id]).read_attribute(params[:type]))
    check.update_attribute(params[:check_type], params[:flag])
    check.update_attribute("#{params[:check_type]}_time", DateTime.now)

    # if check.save
      redirect_to session[:session_url]
    # end
  end


  def new
    @task = Task.new
    @year_options = get_years
  end

  def create
    year = params[:task][:year].to_i
    customers = Customer.all

    customers.each do |customer|
      if customer.tasks.where(year: year).length == 0
        add_tasks(customer, year)
      end
      customer.save!
    end

    redirect_to users_path
  end

  private

  def add_tasks(customer, year)
    task_types = get_task_types_eng()
    check_types = get_check_types()

    task = Task.create(year: year)
    customer.tasks << task

    task_types.each do |type|
      check = Check.create()
      check_types.each do |check_type|
        check.update_attribute(check_type, false)
      end
      task.update_attribute(type, check.id)
    end

    task.save!
  end
end 