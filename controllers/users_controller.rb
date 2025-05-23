require_relative '../config/environment'

class UsersController
  include ResponseHelper
  include PaginationHelper

  def index(current_user, params)
    # paginate users
    data = paginate(User.all.order(created_at: :desc), request.params)
    
    # serialized_users = users.map { |user| UserSerializer.serialize(user) }
    serialized_users = data[:records].map { |user| UserSerializer.serialize(user)}

    json_response(http_status: 200, custom_status: :users_retrieved, data: { users: serialized_users, pagination: data[:meta]})
  end

  def show(current_user, id)
    user = current_user.users.find_by(id: id)
  
    if user
      serialized_user = UserSerializer.serialize(user)
      json_response(http_status: 200, custom_status: :user_retrieved, data: serialized_user)
    else
      json_response(http_status: 404, custom_status: :user_not_found)
    end
  end  

  def create(current_user, request)
    data = JSON.parse(request.body.read) rescue {}

    validator = UserValidator.new(data)

    unless validator.valid?
      return json_response(http_status: 422, custom_status: :invalid_user_data, data: validator.errors)
    end

    user = current_user.users.new(name: data['name'], email: data['email'], password: data['password'])

    if user.save
      serialized_user = UserSerializer.serialize(user)
      json_response(http_status: 201, custom_status: :user_created, data: serialized_user)
    else
      json_response(http_status: 503, custom_status: :invalid_user_data, data: user.errors.full_messages)
    end
  end

  def update(current_user, id, request)
    user = current_user.users.find_by(id: id)
    return not_found_response('user not found') unless user

    data = JSON.parse(request.body.read) rescue {}
    if user.update(name: data['name'], email: data['email'], password: data['password'])
      json_response(http_status: 200, custom_status: :user_updated, data: user)
    else
      bad_request_response(user.errors.full_messages.join(', '))
    end
  end

  def destroy(current_user, id)
    user = current_user.users.find_by(id: id)
    return not_found_response('user not found') unless user

    user.destroy
    json_response(http_status: 200, custom_status: :user_deleted, data: user)
  end
end
