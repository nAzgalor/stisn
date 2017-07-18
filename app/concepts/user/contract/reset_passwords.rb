class User < ApplicationRecord
  module Contract
    class ResetPassword < Reform::Form
      property :password
      property :password_confirmation, virtual: true

      validates :password, :password_confirmation, presence: true
      validates :password, length: { minimum: 6}
      validates :password, confirmation: true
    end
  end
end
