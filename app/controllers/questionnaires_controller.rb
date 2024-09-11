class QuestionnairesController < ApplicationController
  before_action :set_questionnaire, only: %i[show edit update destroy]

  # GET /questionnaires or /questionnaires.json
  def index
    @questionnaires = Questionnaire.all
  end

  # GET /questionnaires/1 or /questionnaires/1.json
  def show
  end

  # GET /questionnaires/new
  def new
    @questionnaire = Questionnaire.new
    @questionnaire.questions.build # Initialize at least one question for new forms
  end

  # GET /questionnaires/1/edit
  def edit
  end

  # POST /questionnaires or /questionnaires.json
  def create
    @questionnaire = Questionnaire.new(questionnaire_params)

    respond_to do |format|
      if @questionnaire.save
        format.html { redirect_to questionnaire_url(@questionnaire), notice: "Questionnaire was successfully created." }
        format.json { render :show, status: :created, location: @questionnaire }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questionnaires/1 or /questionnaires/1.json
  def update
    respond_to do |format|
      if @questionnaire.update(questionnaire_params)
        format.html { redirect_to questionnaire_url(@questionnaire), notice: "Questionnaire was successfully updated." }
        format.json { render :show, status: :ok, location: @questionnaire }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questionnaires/1 or /questionnaires/1.json
  def destroy
    @questionnaire.destroy

    respond_to do |format|
      format.html { redirect_to questionnaires_url, notice: "Questionnaire was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #save responses
  def save_responses
    @questionnaire = Questionnaire.find(params[:id])
  
    params[:responses]&.each do |question_id, response_text|
      question = Question.find(question_id)
  
      case question.question_type
      when 'multiple_choice'

        selected_answers = response_text.map do |answer_id|
          answer = question.answers.find(answer_id)
          answer.name
        end
        Response.create(questionnaire_id: @questionnaire.id, question_id: question_id, response_text: selected_answers.to_json)
  
      when 'single_choice'
        answer = question.answers.find(response_text)
        Response.create(questionnaire_id: @questionnaire.id, question_id: question_id, response_text: answer.name)
  
      when 'long_answer'
        Response.create(questionnaire_id: @questionnaire.id, question_id: question_id, response_text: response_text)
      end
    end
  
    redirect_to @questionnaire, notice: 'Responses saved successfully.'
  end
  
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def questionnaire_params
    params.require(:questionnaire).permit(
      :name,
      questions_attributes: [
        :_destroy,
        :id,
        :question_type,
        :name,
        answers_attributes: [:_destroy, :id, :name]
      ]
    )
  end
end
