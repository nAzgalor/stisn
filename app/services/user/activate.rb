class User < ApplicationRecord
  class Activate
    def call(params)
      @user = User::PostCreate.(params)
      if @user.success?
        @user['model'].activate!
      end
      @user
    end
  end
end
