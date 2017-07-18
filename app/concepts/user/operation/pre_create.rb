class User < ApplicationRecord
  class PreCreate < Trailblazer::Operation
    extend ::Trailblazer::Operation::Contract::DSL

    step :generate_temp_user_password!
    step ::Trailblazer::Operation::Model(User, :new)
    step ::Trailblazer::Operation::Contract::Build()
    step ::Trailblazer::Operation::Contract::Validate()
    step ::Trailblazer::Operation::Contract::Persist()


    contract ::User::Contract::PreCreate

    def generate_temp_user_password!(skill, params, *args)
      require 'securerandom'
      params[:params][:password] = SecureRandom.hex(8)
    end
  end
end
