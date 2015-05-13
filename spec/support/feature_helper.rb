# Helper module for feature spec
module FeatureHelper
  # return ID or CSS selector or path from given name.
  #
  # if name does not registered, return given name.
  def name_to(name, type = :selector)
    if ::NAME_INFO.key?(name)
      ::NAME_INFO[name][type]
    else
      name
    end
  end
end
