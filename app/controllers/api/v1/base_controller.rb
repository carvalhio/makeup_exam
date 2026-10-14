class Api::V1::BaseController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    render json: {
      error: {
        code: "not_found",
        message: "Registro não encontrado"
      }
    }, status: :not_found
  end

  def render_validation_error(record, message)
    render json: {
      error: {
        code: "validation_error",
        message: message,
        details: record.errors.to_hash
      }
    }, status: :unprocessable_content
  end
end
