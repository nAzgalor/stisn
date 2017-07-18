class User < ApplicationRecord
  class Update < Trailblazer::Operation
    extend ::Trailblazer::Operation::Contract::DSL

    step ::Trailblazer::Operation::Model(User, :find)
    step ::Trailblazer::Operation::Contract::Build()
    step ::Trailblazer::Operation::Contract::Validate()
    step ::Trailblazer::Operation::Contract::Persist()

    contract ::User::Contract::Update
  end
end
