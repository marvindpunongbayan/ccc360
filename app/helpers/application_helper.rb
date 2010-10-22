module ApplicationHelper
  def link_to_menu(name, url)
    selected = (name == "Dashboard" && (controller_name == "dashboard" || 
                                        (controller_name == "reviews" && action_name == "new"))) ||
      (name == "People" && controller_name == "people") ||
      (name == "Admin" && controller_name == "question_sheets") ||
      (name == "My Reviews" && controller_name == "reviews" && action_name != "new")
    link_to name, url, :class => (selected ? "selected" : "")
  end

  def starting_review
    controller_name = "reviews" && action_name == "new"
  end

  def gender_icon(person)
    if person.is_male?
      image_tag('icons/user-male.png', :alt => (alt = "#{person.full_name} is a male"), :title => alt)
    else
      image_tag('icons/user-female.png', :alt => (alt = "#{person.full_name} is a female"), :title => alt)
    end
  end
end
