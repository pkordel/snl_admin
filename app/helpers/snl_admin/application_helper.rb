module SnlAdmin
  module ApplicationHelper
    def nav_link(resource, options = {})
      resource = resource.to_s
      klass = resource.classify.safe_constantize
      title = if klass && klass.respond_to?(:model_name)
                klass.model_name.plural.titleize
              end
      title ||= t("#{resource}.title")

      name = options.delete(:name) || title
      path_options = options.delete(:path_options) || {}
      path = options.delete(:path) ||
             send("#{resource}_path", path_options) rescue '#not-implemented'
      if (match_action = options.delete(:match_action))
        matches_controller_name = action_name == match_action
      else
        matches_controller_name = controller_name == resource
      end
      matches_path_options = true
      path_options.each do |key, value|
        matches_path_options = params[key] == value
      end
      css  = (matches_controller_name && matches_path_options) ? 'active' : ''
      content_tag(:li,  class: css) do
        link_to(name, path, options)
      end
    end

    def activity_with_subdomain_link(activity)
      encyclopedia = Encyclopedia.with_id(activity.encyclopedia_id || 1)
      main_app.view_url(activity.article_url,
                        subdomain: Subdomainer.for(encyclopedia.subdomain))
    end

    def article_with_subdomain_link(article)
      main_app.view_url(article.permalink,
                        subdomain: Subdomainer.for(article.encyclopedia.subdomain))
    end

    def activity_partial_for(activity_key)
      {
        'improvement.accept' => 'accepted',
        'improvement.accept_revised' => 'accepted',
        'article.accept' => 'accepted',
        'article.accept_revised' => 'accepted'
      }[activity_key] || 'default'
    end
  end
end
