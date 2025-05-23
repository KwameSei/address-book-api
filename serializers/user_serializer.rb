class UserSerializer
  def self.serialize(user)
    {
      id: user.id,
      name: user.name.titleize,
      email: user.email.downcase,
      created_at: user.created_at.strftime("%d-%m-%Y %H:%M:%S"),
      updated_at: user.updated_at.strftime("%d-%m-%Y %H:%M:%S")
    }
  end
end
