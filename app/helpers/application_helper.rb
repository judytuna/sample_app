# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  #Return a title on a per-page basis                 	#documentation comment
  def title						#method definition
    base_title = "Ruby on Rails Tutorial Sample App"	#variable assignment
    if @title.nil?					#boolean test for nil
      base_title				 	#implicit return
    else
      "#{base_title} | #{h@title}" #the 'h' method converts (eg < to &lt;)
    end
  end

  # exercise 1 from chapter 5
  # create a helper for the local variable logo
  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
  
end
