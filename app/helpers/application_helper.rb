module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade show", role: 'alert') do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

  def login_helper style = ''
    if current_user.is_a? User
      ' '.html_safe + (link_to 'Logout', destroy_user_session_path, method: :delete, class: style)
    else
      (link_to 'Sign up', new_user_registration_path, class: style) + ' '.html_safe +
      (link_to 'Login', new_user_session_path, class: style)
    end
  end
end
