module SnlAdmin
  class Engine < ::Rails::Engine
    isolate_namespace SnlAdmin

    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end
  end
end
