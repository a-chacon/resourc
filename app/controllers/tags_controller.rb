class TagsController < ApplicationController
  def suggestions
    tag = params[:tag]
    tags = Tag.where('name LIKE ?', "%#{tag}%").pluck(:name)
    render json: tags
  end
end
