class ManyAttachmentsController < ApplicationController
  before_action only: %i[show create index]

  def index
    @many = ManyAttachment.all
  end

  def show
    head :not_found if @many.blank?
  end

  def create
    #@many = ManyAttachment.new
    # ManyAttachment.last.image.attachments.first.download

    @many = ManyAttachment.create!
    params[:image].values.each do | values |
      @many.image.attach(values)
      #redirect_to rails_blob_url(message.image.attachments.first)
    end
    #redirect_to message
    if @many.blank?
      handle_error(@many.errors)
    else
      render :show, status: :created
    end
  end

  private

  def extracted_params
    {
      image: params[:image]
      # filename: params[:image].original_filename,
      # content_type: params[:image].content_type
    }
  end
end
