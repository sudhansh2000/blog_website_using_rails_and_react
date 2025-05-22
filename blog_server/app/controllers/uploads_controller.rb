class UploadsController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def image
    if params[:image].present?

      uploaded_io = params[:image]
      filename = SecureRandom.hex + File.extname(uploaded_io.original_filename)
      filepath = Rails.root.join("public", "uploads", filename)

      File.open(filepath, "wb") do |file|
        file.write(uploaded_io.read)
      end

      render json: {
        success: 1,
        file: {
          url: "#{request.base_url}/uploads/#{filename}" # 👈 absolute URL!
        }
      }
    else
      render json: { success: 0, message: "No image uploaded" }
    end
  end
end
