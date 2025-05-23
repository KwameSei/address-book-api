class ContactSerializer
  def self.serialize(contact)
    {
      id: contact.id,
      first_name: contact.first_name.titleize,
      last_name: contact.last_name.titleize,
      phone_num: contact.phone_num,
      created_at: contact.created_at.strftime("%d-%m-%Y %H:%M:%S"),
      updated_at: contact.updated_at.strftime("%d-%m-%Y %H:%M:%S")
    }
  end
end
