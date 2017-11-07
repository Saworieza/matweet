module ApplicationHelper
	def parse(content)
    content = content.gsub(/(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i) do |match|
      link_to(match, hashtag_path(match.gsub('#','')), class: 'hashtags')
    end

    content.gsub(/(@\w+-?\w+)/) do |match|
      # temporary fix before returning user profiles. when its up just ncomment below
      link_to(match, user_path(match.gsub('@','')), class: 'mention')
      # link_to(match, (match.gsub('@','')), class: 'mention')
    end
  end

  def current_user?(user)
    user == current_user
  end
end
