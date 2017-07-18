class User < ApplicationRecord
  module Contract
    class Update < Reform::Form

      include BCrypt

      property :email
      property :old_password, virtual: true
      property :password
      property :password_confirmation, virtual: true

      validates :password, length: { minimum: 6}, if: -> { correct_password_data? }
      validates :password, confirmation: true, if: -> { correct_password_data? }
      validates :email, email_format: {}, if: -> { email_present? }
      validate :uniq_email?, if: -> { email_present? }
      validate :old_password_correct?

      def uniq_email?
        if User.where(email: email).present? && email != User.find(id).email
          errors.add(:email, 'has already been taken')
        end
      end

      def correct_password_data?
        errors.add(:password, 'wrong password input') unless
          (!old_password.empty? &&
           !password.empty? &&
           !password_confirmation.empty?) ||
          (old_password.empty? &&
           password.empty? &&
           password_confirmation.empty?)

        false if old_password.empty? &&
                 password.empty? &&
                 password_confirmation.empty?
      end

      def email_present?
        !email.empty?
      end

      def old_password_correct?
        # errors.add(:old_password, 'not correct') unless authenticate(email, old_password)
        # this doesn't work cuz no method authenticate here
      end
    end
  end
end
