class User < ApplicationRecord
  class ResetPassword < Trailblazer::Operation
    extend ::Trailblazer::Operation::Contract::DSL

    step :prepare_id
    step ::Trailblazer::Operation::Model(User, :find)
    step ::Trailblazer::Operation::Contract::Build()
    step ::Trailblazer::Operation::Contract::Validate()
    step ::Trailblazer::Operation::Contract::Persist()

    contract ::User::Contract::ResetPassword

    def prepare_id(skill, params, *args)
      params[:params][:token] = params[:params][:id]
      params[:params][:id] =
        User.load_from_reset_password_token(params[:params][:token]).id
    end
  end
end
