class ManyAttachmentsController < ApplicationController
  before_action :set_many, only: %i[show create index]

  def index
    @many = ManyAttachment.all
  end

  def show
    head :not_found if @many.blank?
  end

  def create

    @many = ManyAttachment.create!
    params[:image].values.each do | values |
      @many.image.attach(values)
    end
    if @many.blank?
      handle_error(@many.errors)
    else
      render :show, status: :created
    end
  end

  private

  def permitted_params
    params.permit(:id)
  end

  def extracted_params
    {
      image: params[:image]
    }
  end

  def set_many
    @many = ManyAttachment.find(permitted_params[:id])
  end
end
