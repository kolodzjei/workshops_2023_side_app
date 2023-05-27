class LogsController < ApplicationController
  def index
    @logs = params[:user_id].present? ? Log.for_user_id(params[:user_id]) : Log.all

    respond_to do |format|
      format.html
      format.json { render json: @logs }
    end
  end
end
