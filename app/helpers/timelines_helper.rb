module TimelinesHelper
  def delete_micropost_helper micropost
     if current_user.admin?
       link_to 'Delete', micropost, class: 'delete-post', method: :delete, data: { confirm: 'Are you sure?' }
     end
  end
end
