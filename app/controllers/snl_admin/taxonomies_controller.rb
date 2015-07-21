require_dependency "snl_admin/application_controller"

module SnlAdmin
  class TaxonomiesController < ApplicationController
    before_action :set_taxonomy, except: [:index]
    respond_to :html

    def index
      @taxonomies = if params[:query]
                      term = params[:query].strip
                      conditions = "title ILIKE ?"
                      SnlAdmin.taxonomy_class.where(conditions, "%#{term}%")
                      .order('id asc')
                    else
                      SnlAdmin.taxonomy_class.order('id asc')
                    end.page params[:page]
    end

    def show
      @title = taxonomy.title
    end

    def edit
      @title = t('edit_taxonomy')
    end

    def new
      @title = t('new_taxonomy')
    end

    def update
      if @taxonomy.update_attributes taxonomy_params
        respond_with @taxonomy
      else
        render :edit
      end
    end

    def create
      @taxonomy = SnlAdmin.taxonomy_class.new taxonomy_params
      if @taxonomy.save
        respond_with @taxonomy
      else
        render :new
      end
    end

    def destroy
      if @taxonomy.has_children?
        notice = t('destroy_taxonomy_forbidden')
      else
        @taxonomy.destroy
        notice = t('destroy_taxonomy')
      end
      redirect_to taxonomies_path, notice: notice
    end

    private

    def taxonomy
      @decorated_taxonomy ||= TaxonomyPresenter.new(@taxonomy, view_context)
    end
    helper_method :taxonomy

    def set_taxonomy
      @taxonomy = if params[:id].present?
                    SnlAdmin.taxonomy_class.find(params[:id])
                  else
                    SnlAdmin.taxonomy_class.new
                  end
    end

    def taxonomy_params
      params.require(:taxonomy).permit(:title,
                                       :parent_id,
                                       :position,
                                       :description)
    end

    def collection_for_parent_id(record)
      record_id = record.id || 0
      ancestry_options(
        Taxonomy.scoped.where("id != ?", record_id)
        .select([:id, :title, :ancestry, :position])
        .arrange(order: 'ancestry, position'))
    end
    helper_method :collection_for_parent_id

    def ancestry_options(nodes, string = nil)
      array = []
      nodes.each do |node, children|
        array << [format_string(string, node), node.id]
        if children.size > 0
          array.concat(ancestry_options(children, format_string(string, node)))
        end
      end
      array
    end

    def format_string(string, node)
      [string, "(#{node.position}) #{node.title}"].compact.join(" | ")
    end
  end
end
