module UsersHelper
  def preferences_field(form, name)
    case name
    when Preference::BOOLEAN_FIELD_REGEXP
      form.check_box(name)
    else
      form.text_field(name)
    end
  end
end
