module UsersHelper

  # 引数で与えられたユーザーのGravatar画像を返す
  # 7.1.4演習No.2
  # def gravatar_for(user, options = { size: 80 })
  # 7.1.4演習No.3
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    # 7.1.4演習No.3
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
