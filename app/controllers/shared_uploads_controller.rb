class SharedUploadsController < ApplicationController
  def show
    @upload = Upload.find_by!(url: params[:url])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Invalid or expired link."
  end
end
