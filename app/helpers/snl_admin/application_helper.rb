module SnlAdmin
  module ApplicationHelper
    def nav_link(resource, options={})
      resource = resource.to_s
      klass = resource.classify.safe_constantize
      title = klass.model_name.plural.titleize if klass
      title ||= t("#{resource}.title")

      name = options.delete(:name) || title
      path = options.delete(:path) || send("#{resource}_path") rescue '#not-implemented'
      css  = controller_name == resource ? 'active' : ''

      content_tag(:li,  class: css) do
        link_to(name, path, options)
      end
    end
  end
end
