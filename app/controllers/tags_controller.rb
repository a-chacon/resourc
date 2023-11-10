class TagsController < ApplicationController
  before_action :set_user, only: ['show']

  def suggestions
    tag = params[:tag]
    tags = Tag.where('name LIKE ?', "%#{tag}%").pluck(:name)
    render json: tags
  end

  def show
    @popular_tags = Tag.select('tags.*, COUNT(links_tags.link_id) AS link_count')
                       .joins(:links)
                       .group('tags.id')
                       .order('link_count DESC')
                       .limit(20)

    params[:q] = {} if params[:q].nil?
    @q = Link.ransack(params[:q].merge({ tags_name_eq: @tag.name }))
    @search_url = tag_path(@tag)

    @pagy, @records = pagy(@q.result(distinct: true).with_attached_thumbnail.includes(:tags,
                                                                                      user_links: { user: { avatar_attachment: :blob } }))

    @page_title = t('tags.show.title', total: @pagy.count, tag: @tag.name)
    @page_description = t('meta_description')
  end

  private

  def set_user
    @tag = Tag.find(params[:id])
  end
end
