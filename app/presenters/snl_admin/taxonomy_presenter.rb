module SnlAdmin
  class TaxonomyPresenter < SimpleDelegator
    attr_reader :taxonomy

    def initialize(taxonomy)
      super(taxonomy)
      @taxonomy = taxonomy
    end

    def title
      taxonomy.title
    end
  end
end
