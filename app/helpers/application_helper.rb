module ApplicationHelper
  def link_to_menu(name, url)
    selected = (name == "Dashboard" && controller_name == "dashboard") ||
      (name == "People" && controller_name == "people") ||
      (name == "Admin" && controller_name == "question_sheets") ||
      (name == "My Reviews" && controller_name == "reviews")
    link_to name, url, :class => (selected ? "selected" : "")
  end
end
