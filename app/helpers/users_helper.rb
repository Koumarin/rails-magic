module UsersHelper
  ### Returns the gravatar for the given user.
  def gravatar_for user, size: 80
    id  = Digest::MD5::hexdigest user.email.downcase
    url = "https://secure.gravatar.com/avatar/#{id}"

    image_tag url, alt: user.name, class: 'gravatar', size: size
  end
end
