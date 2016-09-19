class ChecksController < ApplicationController

  def edit
    @check = Check.find(params[:id])
    
  end

  def update
    @check = Check.find(params[:id])
    @check.note = params[:check][:note]

    if @check.save
      redirect_to session[:session_url]
    else
      render :edit
    end
  end
end