class UploadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_upload, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[show edit update destroy]

  # GET /uploads
  def index
    @uploads = current_user.uploads.page(params[:page]).per(9)
  end

  # GET /uploads/1
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  def create
    @upload = current_user.uploads.build(upload_params)

    if @upload.save
      redirect_to @upload, notice: "Upload was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /uploads/1
  def update
    if @upload.update(upload_params)
      redirect_to @upload, notice: "Upload was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /uploads/1
  def destroy
    @upload.destroy
    redirect_to uploads_path, notice: "Upload was successfully destroyed.", status: :see_other
  end

  private

  def set_upload
    @upload = Upload.find(params[:id])
  end

  def authorize_user!
    redirect_to uploads_path, alert: "Not authorized" unless @upload.user == current_user
  end

  def upload_params
    params.require(:upload).permit(:title, :description, :file)
  end
end
