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

  def table_headers
    content_tag :thead do
      content_tag :tr do
        yield
      end
    end
  end

  def table_header( sort: false, title:, slug: nil, default: false )
    slug ||= title.parameterize

    sort_by, order = params[:sort].split ',' if params[:sort]
    if sort_by
      sort_by = nil unless sort_by == slug
    else
      sort_by = slug if default
    end

    order ||= 'desc'


    content_tag(:th, class: sort_by ? order : nil) do
      if sort
        link_to "?sort=#{slug},#{order == 'asc' ? 'desc' : 'asc'}" do
          title.html_safe + content_tag(:div, class: 'sort') do
            concat content_tag(:i, nil, class: 'fa fa-caret-up')
            concat content_tag(:i, nil, class: 'fa fa-caret-down')
          end
        end
      else
        title
      end
    end
  end
end
