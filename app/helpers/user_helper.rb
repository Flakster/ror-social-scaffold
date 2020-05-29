# frozen_string_literal: true

module UserHelper
  def request_friendship_caller_set(page)
    cookies[:caller_page] = page
  end

  def request_friendship_caller
    cookies[:caller_page]
  end

  def show_request(user_id)
    return if current_user.id == user_id

    if can_request_friendship?(user_id)
      render html: link_to('Invite to friendship',  users_request_friendship_path(receiver: user_id), class: 'profile-link',
      method: :request_friendship)
    else
      f = Friendship.friendship(current_user.id, user_id).first
      render html: f.status.capitalize if  f.status != 'rejected'
    end
  end
end