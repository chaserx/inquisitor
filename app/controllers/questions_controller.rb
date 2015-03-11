class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /users/1/questions
  # GET /users/1/questions.json
  def index
    @questions = current_user.questions.all
  end

  # GET /users/1/questions/1
  # GET /users/1/questions/1.json
  def show
  end

  # GET /users/1/questions/new
  def new
    @question = Question.new
  end

  # GET /users/1/questions/1/edit
  def edit
  end

  # POST /users/1/questions
  # POST /users/1/questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html {
          redirect_to [current_user, @question],
                      notice: 'Question was successfully created.'
        }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1/questions/1
  # PATCH/PUT /users/1/questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html {
          redirect_to [current_user, @question],
                      notice: 'Question was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1/questions/1
  # DELETE /users/1/questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html {
        redirect_to user_questions_url(current_user),
                    notice: 'Question was successfully destroyed.'
      }
      format.json { head :no_content }
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:body, :askable).merge(user: current_user)
  end
end
