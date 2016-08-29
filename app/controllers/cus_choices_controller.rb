class CusChoicesController < ApplicationController

  def new
    @customers = Customer.all.pluck(:name_abrev)
  end

  def create
    @customer = Customer.find_by_name_abrev(params[:choice][:name_abrev])

    if @customer
      redirect_to edit_customer_path(@customer)
    else 
      render :new
    end
  end
end