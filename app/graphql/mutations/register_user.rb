class Mutations::RegisterUser < Mutations::BaseMutation
  argument :email, String, required: true
  argument :password, String, required: true

  field :token, String, null: true
  field :user, Types::UserType, null: true

  def resolve(email:, password:)
    user = User.new(email: email, password: password)
    if user.save
      {user: user, errors: []}
    else
      {user:nil, errors: user.errors.full_messages}
    end


  end
end
