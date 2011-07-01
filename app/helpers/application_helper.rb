module ApplicationHelper
  def link_to_menu(name, url, params = {})
    selected = (name == "Home" && controller_name == "dashboard") || 
      (name == "People" && controller_name == "people") ||
      (name == "Administer Review Forms" && controller_name == "question_sheets") ||
      (name == "Administer Review(s)" && controller_name == "reviews" && action_name != "new")
    link_to name, url, params.merge(:class => params[:class].to_s + (" selected" if selected).to_s)
  end

  def starting_review
    controller_name = "reviews" && action_name =~ /new/
  end

  def gender_icon(person)
    return "" if person.nil?
    if person.gender && person.is_male?
      image_tag('icons/user-male.png', :alt => (alt = "#{person.full_name} is a male"), :title => alt)
    elsif person.gender && person.is_female?
      image_tag('icons/user-female.png', :alt => (alt = "#{person.full_name} is a female"), :title => alt)
    else
      image_tag('icons/user-silhouette.png', :alt => (alt = "#{person.full_name}"), :title => alt)
    end
  end

  def person_gender_email(person)
    "#{gender_icon(person)} #{person.full_name} (#{person.email})".html_safe
  end

  def calendar_date_select_tag(name, value = nil, options = {})
    options.merge!({'data-calendar' => true})
    value = case
            when value.is_a?(Time)
              l(value.to_date)
            when value.is_a?(Date)
              l(value)
            else
              value
            end
    text_field_tag(name, value, options )
  end

  def person_link_if_authed(person)
    return "" unless person.present?
    if can_see_person?(person)
      link_to(person.full_name, person_url(person.id))
    else
      person.full_name
    end
  end

  def view_has_own_flash
    return (params[:controller] == "people" && params[:action] == "index") || 
      (params[:controller] == "dashboard" && params[:action] == "index") || 
      (params[:controller] == "question_sheets")
  end

  def print_url(params = '')
    if request.url =~ /(.*)\/edit/
      $1 + "?view=print"
    elsif request.url =~ /\?/
      request.url + params
    else
      request.url + "?" + params
    end
  end
end
