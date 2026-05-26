class ExamPeriodsController < ApplicationController
  before_action :set_exam_period, only: %i[ show edit update destroy ]

  # GET /exam_periods or /exam_periods.json
  def index
    @exam_periods = ExamPeriod.all
  end

  # GET /exam_periods/1 or /exam_periods/1.json
  def show
    @exam_period = ExamPeriod.find(params[:id])

    @exam_requests =
      @exam_period.exam_requests
                  .includes(student: :school_class)
                  .includes(:subjects)

    @requests_grouped =
      @exam_requests.group_by do |request|

        school_class = request.student.school_class

        "#{school_class.grade} #{school_class.identifier}"

      end
  end

  # GET /exam_periods/new
  def new
    @exam_period = ExamPeriod.new
  end

  # GET /exam_periods/1/edit
  def edit
  end

  # POST /exam_periods or /exam_periods.json
  def create
    @exam_period = ExamPeriod.new(exam_period_params)

    respond_to do |format|
      if @exam_period.save
        format.html { redirect_to @exam_period, notice: "Exam period was successfully created." }
        format.json { render :show, status: :created, location: @exam_period }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @exam_period.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /exam_periods/1 or /exam_periods/1.json
  def update
    respond_to do |format|
      if @exam_period.update(exam_period_params)
        format.html { redirect_to @exam_period, notice: "Exam period was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @exam_period }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @exam_period.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /exam_periods/1 or /exam_periods/1.json
  def destroy
    @exam_period.destroy!

    respond_to do |format|
      format.html { redirect_to exam_periods_path, notice: "Exam period was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam_period
      @exam_period = ExamPeriod.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exam_period_params
      params.require(:exam_period).permit(:stage, :exam_type, :active)
    end
end
