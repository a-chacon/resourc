class TagsController < ApplicationController
  include AuthorizationConcern

  before_action :set_user, only: ['show']
  before_action :authorize, only: [:show]

  def suggestions
    tag = params[:tag]
    tags = Tag.where('name LIKE ?', "%#{tag}%").pluck(:name)
    render json: tags
  end

  def show
    params[:q] = {} if params[:q].nil?

    @q = Link.ransack(params[:q].merge({ tags_name_eq: @tag.name }))
    @q.sorts = ['created_at desc', 'reaction_like desc'] if @q.sorts.empty?

    @search_url = tag_path(@tag)

    @pagy, @records = pagy(@q.result(distinct: true).active.with_attached_thumbnail.includes(:tags,
                                                                                             user_links: { user: { avatar_attachment: :blob } }))

    @page_title = t('tags.show.title', total: @pagy.count, tag: @tag.name)
    @page_description = t('meta_description')

    return render layout: 'layouts/main_links' unless @current_user

    @current_user_reactions = @current_user.user_links.where(relationship_type: %i[like
                                                                                   dislike]).where(link_id: @records.pluck(:id))
    render layout: 'layouts/main_links'
  end

  private

  def set_user
    @tag = Tag.find(params[:id])
  end
end
