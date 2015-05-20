module UsersHelper
  def preferences_field(form, name)
    html = ""
    case name
    when Preference::BOOLEAN_FIELD_REGEXP
      html += content_tag(:div, class: "controls") do
        form.label(name, class: "checkbox") do
          form.check_box(name) +
            t(name, scope: "helpers.label.user[preferences]")
        end
      end
    else
      html += form.label(name, class: "control-label")
      html += content_tag(:div, class: "controls") do
        form.text_field(name)
      end
    end
    raw(html)
  end
end
