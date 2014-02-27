module ApplicationHelper
  def user_avatar
    image_tag ( current_user.avatar or 'default-avatar.png' ), class: 'avatar'
  end

  def namespace
    controller_path.split('/').first
  end

  def sidebar_link( text:, link:, icon:, classes: '' )
    class_name = current_page?(link) ? 'current' : ''

    link_to link, class: class_name do
      content_tag(:i, nil, class: " fa fa-#{icon} #{classes}") + text
    end
  end
end
