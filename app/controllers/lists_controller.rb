class ListsController < ApplicationController
  include AuthorizationConcern

  before_action :authorize!, except: ['show']
  before_action :authorize, only: ['show']
  before_action :set_list, only: %i[show edit update destroy]

  # GET /lists or /lists.json
  def index
    @lists = @current_user.lists
  end

  # GET /lists/1 or /lists/1.json
  def show
    @pagy, @records = pagy(Link.joins(:link_lists).active.where(link_lists: { list_id: @list.id }))

    return unless @current_user

    @current_user_reactions = @current_user.user_links.where(relationship_type: %i[like
                                                                                   dislike]).where(link_id: @records.pluck(:id))
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit; end

  # POST /lists or /lists.json
  def create
    @list = List.new(list_params)
    @list.users << @current_user

    respond_to do |format|
      if @list.save
        format.html { redirect_to lists_path, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to list_url(@list), notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_list
    @list = List.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def list_params
    params.require(:list).permit(:title, :description, :public)
  end
end
