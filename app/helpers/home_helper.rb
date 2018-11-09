module HomeHelper
  def get_user_image(user)
    if user.present? && user.image.present? && user.image.avatar_url.present?
      user.image.avatar_url
    else
      '/assets/user_logo.png'
    end
  end
end
