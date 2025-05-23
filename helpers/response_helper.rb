require_relative '../config/environment'

module ResponseHelper
  def json_response(http_status:, custom_status:, data: {})
    code_info = CustomCode::CODES[custom_status] || { code: 9999, message: "Unknown status" }
  
    response = {
      code: code_info[:code],
      message: code_info[:message],
      data: data
    }
  
    [http_status, { 'Content-Type' => 'application/json' }, [response.to_json]]
  end  

  # Shortcuts
  # def success_response(data = nil, msg = nil)
  #   json_response(http_status: 200, custom_status: :success, data: data, override_message: msg)
  # end

  # def registration_success_response(data = nil, msg = nil)
  #   json_response(http_status: 201, custom_status: :internal_error, override_message: msg)
  # end

  # def created_response(data = nil, msg = nil)
  #   json_response(http_status: 202, custom_status: :created, data: data, override_message: msg)
  # end

  # def accepted_response(data = nil, msg = nil)
  #   json_response(http_status: 203, custom_status: :accepted, data: data, override_message: msg)
  # end

  # def no_content_response(msg = nil)
  #   json_response(http_status: 204, custom_status: :not_found, override_message: msg)
  # end

  # def bad_request_response(msg = nil)
  #   json_response(http_status: 400, custom_status: :bad_request, override_message: msg)
  # end

  # def unauthorized_response(msg = nil)
  #   json_response(http_status: 401, custom_status: :unauthorized, override_message: msg)
  # end

  # def forbidden_response(msg = nil)
  #   json_response(http_status: 402, custom_status: :forbidden, override_message: msg)
  # end

  # def not_found_response(msg = nil)
  #   json_response(http_status: 403, custom_status: :not_found, override_message: msg)
  # end

  # def method_not_allowed_response(msg = nil)
  #   json_response(http_status: 404, custom_status: :method_not_allowed, override_message: msg)
  # end

  # def conflict_response(msg = nil)
  #   json_response(http_status: 409, custom_status: :conflict, override_message: msg)
  # end

  # def internal_error_response(msg = nil)
  #   json_response(http_status: 500, custom_status: :internal_error, override_message: msg)
  # end
end
