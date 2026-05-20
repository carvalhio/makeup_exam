class ExamRequestsController < ApplicationController
  before_action :set_exam_request, only: %i[ show edit update destroy ]

  # GET /exam_requests or /exam_requests.json
  def index
    current_period = ExamPeriod.current

    @exam_requests = ExamRequest.where(
      exam_period: current_period
    )
  end

  # GET /exam_requests/1 or /exam_requests/1.json
  def show
  end

  # GET /exam_requests/new
  def new
    @exam_request = ExamRequest.new
    
  end

  # GET /exam_requests/1/edit
  def edit
  end

  # POST /exam_requests or /exam_requests.json
  def create
    @exam_request = ExamRequest.new(exam_request_params)
    @exam_request.exam_period = ExamPeriod.current

    respond_to do |format|
      if @exam_request.save
        format.html { redirect_to @exam_request, notice: "Exam request was successfully created." }
        format.json { render :show, status: :created, location: @exam_request }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @exam_request.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /exam_requests/1 or /exam_requests/1.json
  def update
    respond_to do |format|
      if @exam_request.update(exam_request_params)
        format.html { redirect_to @exam_request, notice: "Exam request was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @exam_request }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @exam_request.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /exam_requests/1 or /exam_requests/1.json
  def destroy
    @exam_request.destroy!

    respond_to do |format|
      format.html { redirect_to exam_requests_path, notice: "Exam request was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

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
    # Use callbacks to share common setup or constraints between actions.
    def set_exam_request
      @exam_request = ExamRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
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
