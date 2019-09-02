class BulksController < ApplicationController
  before_action only: %i[show create index]

  def index
    @bulk = Bulk.all
  end

  def show
    head :not_found if @bulk.blank?
  end

  def create
    @bulk = Bulk.new(extracted_params)
    if @bulk.save
      render :show, status: :created
    else
      handle_error(@bulk.errors)
    end
    read_csv
  end

  private

  def read_csv
    if params[:file].content_type.include?('csv')
      CreateBulkJob.perform_now(@bulk.id)
    else
      logger.error "File type not csv"
    end
  end

  def extracted_params
    {
      file: params[:file],
      filename: params[:file].original_filename,
      content_type: params[:file].content_type
    }
  end

  def permitted_params
    params.permit(:id)
  end

  def set_bulk
    @bulk = Bulk.find(permitted_params[:id])
  end
end
