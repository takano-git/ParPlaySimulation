module UsersHelper
  # def bootstrap_devise_error_messages!
  #   return "" if resource.errors.empty?

  #   html = ""
  #   resource.errors.full_messages.each do |error_message|
  #     html += <<-EOF
  #     <div class="alert alert-danger alert-dismissible" role="alert">
  #       <button type="button" class="close" data-dismiss="alert">
  #         <span aria-hidden="true">&times;</span>
  #         <span class="sr-only">close</span>
  #       </button>
  #       #{error_message}
  #     </div>
  #     EOF
  #   end
  #   html.html_safe
  # end

  def premium_check(user)
    if user.premium?
      content_tag(:span, "&#9733;".html_safe, style: "color: #dab300;")
    end
  end
end