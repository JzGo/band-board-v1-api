class BandsController < ApplicationController
  def index
    bands = Band.where(user_id: params[:user_id])
    render json: bands
  end
end
