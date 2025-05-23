class Contact < ActiveRecord::Base
  belongs_to :user
  before_save :normalize_phone

  validates :first_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :phone_num, presence: true

  def normalize_phone
    if phone_num.start_with?('+233')
      self.phone = '0' + phone_num[4..]
    elsif phone_num.start_with?('233')
      self.phone = '0' + phone_num[3..]
    end
  end
end