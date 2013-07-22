module ApplicationHelper
  def add_style_to_upvoted topic
    if current_user
      current_user.upvoted_topics.include?(topic) ? 'upvoted' : 'not_voted'
    end
  end

  def avatar_url user
    if user.avatar.present?
      user.avatar
    else
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=200&d=#{CGI.escape(default_url)}"
    end
  end

  def non_anonymous_topics topics
    topics.reject(&:anonymous)
  end

  def determine_plural number, word
    word = pluralize(number, word)
    word.delete("0-9").strip
  end
end
