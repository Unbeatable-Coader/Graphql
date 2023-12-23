module Mutations
  class LoginUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(email:, password:)
      user = User.find_by(email: email)

      if user&.authenticate(password)
        token = JWT.encode({ user_id: user.id }, 'your_secret_key', 'HS256')
        { token: token, user: user }
      else
        raise GraphQL::ExecutionError, 'Invalid email or password'
      end
    end
  end
end
