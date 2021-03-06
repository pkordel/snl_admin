module SnlAdmin
  class Engine < ::Rails::Engine
    isolate_namespace SnlAdmin

    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    # initializer "snl_admin.assets.precompile", group: :all do |app|
    #   app.config.assets.precompile += %w[
    #     snl_admin/application.css.scss
    #     snl_admin/application.js
    #   ]
    # end
  end
end
