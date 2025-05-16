module ResponseHelper
  def not_found_response(message)
    halt 404, json(error: message)
  end
end