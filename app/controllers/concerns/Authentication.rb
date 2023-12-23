
module Authentication
  def current_user
    return nil unless request.headers['Authorization'].present?

    token = request.headers['Authorization'].split(' ').last
    decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    user_id = decoded_token['user_id']
    @current_user ||= User.find_by(id: user_id)
  rescue JWT::DecodeError
    nil
  end

  def authenticate_user!
    raise GraphQL::ExecutionError, 'Authentication required' unless current_user
  end
end
