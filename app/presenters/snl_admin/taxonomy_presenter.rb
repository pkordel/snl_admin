module SnlAdmin
  class TaxonomyPresenter < SimpleDelegator
    attr_reader :taxonomy, :template

    def initialize(taxonomy, template)
      super(taxonomy)
      @taxonomy = taxonomy
      @template = template
    end

    def title
      @title ||= taxonomy.title
    end

    def description
      @description ||= taxonomy.description
    end

    def parents_path
      taxonomy.ancestors.select([:id, :title])
        .to_a
        .inject([]) do |ary, parent|
          ary << context.link_to(parent.title, parent)
        end.join(' &raquo; ').html_safe
    end
  end
end
