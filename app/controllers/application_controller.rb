class ApplicationController < ActionController::API
	def full_resource_errors(resource)
    errors = resource.errors.full_messages.join('<br>').html_safe
    render status: :unprocessable_entity, json: {errors: errors}
  end
end
