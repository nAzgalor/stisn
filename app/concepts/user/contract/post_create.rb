class User < ApplicationRecord
  module Contract
    class PostCreate < Reform::Form
        property :email
        property :password
        property :password_confirmation, virtual: true

        validates :email, :password, :password_confirmation, presence: true
        validates :password, length: { minimum: 6}
        validates :password, confirmation: true
        validates :email, email_format: {}
        validate :uniq_email?

        def uniq_email?
          if User.where(email: email).present? && email != User.find(id).email
            errors.add(:email, 'has already been taken')
          end
        end
    end
  end
end
