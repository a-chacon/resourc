class FeedbacksController < ApplicationController
  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # POST /feedbacks or /feedbacks.json
  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      redirect_to root_url, notice: 'Feedback was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_feedback
  # @feedback = Feedback.find(params[:id])
  # end

  # Only allow a list of trusted parameters through.
  def feedback_params
    params.require(:feedback).permit(:email, :comment)
  end
end
