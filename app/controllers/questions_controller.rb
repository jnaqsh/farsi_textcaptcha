class QuestionsController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create, :api_get]
  def unapproved
    @questions = Question.unapproved

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new
    @question.textcaptcha
    @question.answers.build

    bypass_captcha_or_not @question

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(params[:question])

    @question.approved = false unless current_user

    bypass_captcha_or_not @question

    respond_to do |format|
      if @question.save
        format.html { redirect_to root_path, notice: I18n.t('controllers.questions.create.flash.success') }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: I18n.t('controllers.questions.update.flash.success') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  def approve
    @question = Question.find(params[:id])

    @question.approve

    respond_to do |format|
      format.html { redirect_to @question,
        notice: I18n.t('controllers.questions.approve.flash.success') }
    end
  end

  def api_get
    @user = User.find_by_api_key(params[:api_key])

    if @user && @user.api_key == "demo"
      @question = Question.demo_question
    else
      @question = Question.random if @user
    end

    respond_to do |format|
      format.xml
    end
  end
end
