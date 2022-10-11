module UsersHelper
  def user_name(user)
    user.email.split('@')
  end
end
