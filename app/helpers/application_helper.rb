# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  #Return a title on a per-page basis
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  # exercise 1 from chapter 5
  # create a helper for the local variable logo
  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
  
end
