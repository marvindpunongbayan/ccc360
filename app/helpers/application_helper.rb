module ApplicationHelper
  def link_to_menu(name, url, params = {})
    selected = (name == "Dashboard" && controller_name == "dashboard") || 
      (name == "People" && controller_name == "people") ||
      (name == "Administrate Questionnaires" && controller_name == "question_sheets") ||
      (name == "Administrate Reviews" && controller_name == "reviews" && action_name != "new")
    link_to name, url, params.merge(:class => params[:class].to_s + (" selected" if selected).to_s)
  end

  def starting_review
    controller_name = "reviews" && action_name =~ /new/
  end

  def gender_icon(person)
    return "" if person.nil?
    if person.is_male?
      image_tag('icons/user-male.png', :alt => (alt = "#{person.full_name} is a male"), :title => alt)
    #elsif person.is_female?
    #  image_tag('icons/user-female.png', :alt => (alt = "#{person.full_name} is a female"), :title => alt)
    else
      image_tag('icons/user-silhouette.png', :alt => (alt = "#{person.full_name}"), :title => alt)
    end
  end

  def person_gender_email(person)
    "#{gender_icon(person)} #{person.full_name} (#{person.email})".html_safe
  end
end
