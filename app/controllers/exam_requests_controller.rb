class ExamRequestsController < ApplicationController
  before_action :set_exam_request, only: %i[show edit update destroy]
  before_action :load_exam_menu
  before_action :set_exam_period

  # GET /exam_requests
  def index
     @exam_requests = @exam_period.exam_requests.includes(:student, :subjects)
  end

  # GET /exam_requests/1
  def show
  end

  # GET /exam_requests/new
  def new
   @exam_request = @exam_period.exam_requests.new
  end

  # GET /exam_requests/1/edit
  def edit
  end

  # POST /exam_requests
  def create
       @exam_request = @exam_period.exam_requests.new(exam_request_params)

    if @exam_request.save
      redirect_to exam_period_exam_requests_path(@exam_period),
                  notice: "Solicitação criada com sucesso"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exam_requests/1
  def update
    respond_to do |format|
      if @exam_request.update(exam_request_params)
        format.html { redirect_to @exam_request, notice: "Atualizado com sucesso", status: :see_other }
        format.json { render :show, status: :ok, location: @exam_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exam_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exam_requests/1
  def destroy
    @exam_request.destroy!

    respond_to do |format|
      format.html { redirect_to exam_period_exam_requests_path(@exam_period), notice: "Deletado com sucesso!.", status: :see_other }
      format.json { head :no_content }
    end
  end





  # GET /exam_requests/stage
  def stage
    @stage = params[:stage]

    @partial_period = ExamPeriod.find_by(
      stage: @stage,
      exam_type: "Parcial"
    )

    @global_period = ExamPeriod.find_by(
      stage: @stage,
      exam_type: "Global"
    )
  end

  private
  def load_exam_menu
     @exam_menu = ExamPeriod
    .select(:id, :stage, :exam_type)
    .order(:stage)

  @exam_menu_grouped = @exam_menu.group_by(&:stage)
  end

  def set_exam_request
    @exam_request = ExamRequest.find(params[:id])
  end

  def set_exam_period
  @exam_period =
    if params[:exam_period_id]
      ExamPeriod.find(params[:exam_period_id])
    elsif @exam_request.present?
      @exam_request.exam_period
    end
  end

  def exam_request_params
    params.require(:exam_request).permit(
      :student_id,
      :exam_period_id,
      :reason,
      :reason_description,
      subject_ids: []
    )
  end
end

