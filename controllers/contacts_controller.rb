require_relative '../config/environment'

class ContactsController
  include ResponseHelper
  include PaginationHelper

  def index(current_user, params)
    data = paginate(Contact.all.order(created_at: :desc), params)

    # serialized_contacts = contacts.map { |contact| ContactSerializer.serialize(contact) }
    serialized_contacts = data[:records].map { |contact| ContactSerializer.serialize(contact) }

    json_response(http_status: 200, custom_status: :contacts_retrieved, data: { contacts: serialized_contacts, pagination: data[:meta] })
  end

  def show(current_user, id)
    contact = current_user.contacts.find_by(id: id)

    if contact
      serialized_contact = ContactSerializer.serialize(contact)
      return json_response(http_status: 200, custom_status: :contact_retrieved, data: serialized_contact)
    else
      return json_response(http_status: 404, custom_status: :contact_not_found)
    end
  end

  def create(current_user, request)
    data = JSON.parse(request.body.read) rescue {}

    validator = ContactValidator.new(data)

    unless validator.valid?
      return json_response(http_status: 422, custom_status: :invalid_contact_data, data: validator.errors)
    end

    contact = current_user.contacts.new(first_name: data['first_name'], last_name: data['last_name'], phone_num: data['phone_num'])

    if contact.save
      serialized_contact = ContactSerializer.serialize(contact)
      json_response(http_status: 201, custom_status: :contact_created, data: serialized_contact)
    else
      json_response(http_status: 503, custom_status: :invalid_contact_data)
    end
  end

  def update(current_user, id, request)
    contact = current_user.contacts.find_by(id: id)
    return json_response(http_status: 422, custom_status: :contact_not_found, data: {}) unless contact

    data = JSON.parse(request.body.read) rescue {}

    validator = ContactValidator.new(data)

    unless validator.valid?
      return json_response(http_status: 422, custom_status: :invalid_contact_data, data: validator.errors)
    end

    if contact.update(first_name: data['first_name'], last_name: data['last_name'], phone_num: data['phone_num'])
      return json_response(http_status: 200, custom_status: :contact_updated, data: contact)
    else
      return json_response(http_status: 422, custom_status: :invalid_contact_data, data: validator.errors)
    end
  end

  def destroy(current_user, id)
    contact = current_user.contacts.find_by(id: id)
    return json_response(http_status: 422, custom_status: :contact_not_found, data: {}) unless contact

    contact.destroy
    json_response(http_status: 200, custom_status: :contact_deleted, data: contact)
  end
end