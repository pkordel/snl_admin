module SnlAdmin
  module ApplicationHelper
    def nav_link(resource, options={})
      resource = resource.to_s
      klass = resource.classify.safe_constantize
      title = klass.model_name.plural.titleize if klass
      title ||= t("#{resource}.title")

      name = options.delete(:name) || title
      path_options = options.delete(:path_options) || {}
      path = options.delete(:path) || send("#{resource}_path", path_options) rescue '#not-implemented'
      matches_controller_name = controller_name == resource
      matches_path_options = true
      path_options.each do |key, value|
        matches_path_options = params[key] == value
      end
      css  = (matches_controller_name && matches_path_options) ? 'active' : ''
      content_tag(:li,  class: css) do
        link_to(name, path, options)
      end
    end
  end
end
