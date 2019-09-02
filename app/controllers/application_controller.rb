# frozen_string_literal: true

class ApplicationController < ActionController::API
  def handle_error(errors)
    message = 'Record is not valid'
    render json: { message: message, errors: errors.full_messages }, status: :unprocessable_entity
    return
  end
  def bulk_creating
    message = 'created bulk records'
    render json: { message: message }
    return
  end
end
