class User < ApplicationRecord
  module Contract
    class PreCreate < Reform::Form
      property :email
      property :password

      validates :email, :password, presence: true
      validates :email, email_format: {}
      validates_uniqueness_of :email
    end
  end
end
