class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :destroy]
  before_action :set_question

  # GET /user/1/question/1/answers
  # GET /answers.json
  def index
    @answers = @question.answers.all
  end

  # GET /user/1/question/1/answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  # def new
  #   @answer = Answer.new
  # end

  # GET /answers/1/edit
  # def edit
  # end

  # POST /answers
  # POST /answers.json
  # def create
  #   @answer = Answer.new(answer_params)

  #   respond_to do |format|
  #     if @answer.save
  #       format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
  #       format.json { render :show, status: :created, location: @answer }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @answer.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  # def update
  #   respond_to do |format|
  #     if @answer.update(answer_params)
  #       format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @answer }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @answer.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html {
        redirect_to user_question_answers_url(current_user, @question),
                    notice: 'Answer was successfully destroyed.'
      }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params[:answer]
  end
end
