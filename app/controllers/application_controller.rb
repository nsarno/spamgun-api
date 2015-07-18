class ApplicationController < ActionController::API
  include Knock::Authenticable

private
  def save_and_render resource, update_params = {}, status: :ok
    if (resource.new_record? ? resource.save : resource.update(update_params))
      render json: resource, status: status, location: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end
end
