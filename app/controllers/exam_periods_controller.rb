class ExamPeriodsController < ApplicationController
  before_action :set_exam_period, only: %i[ show edit update destroy ]

  # GET /exam_periods
  def index
    @exam_periods = ExamPeriod.all
  end

  # GET /exam_periods/1
  def show
    @exam_period = ExamPeriod.find(params[:id])

    @exam_requests =
      @exam_period.exam_requests
                  .includes(student: :school_class)
                  .includes(:subjects)
                  .sort_by do |request|
        school_class = request.student.school_class

        [
          grade_order_value(school_class.grade),
          school_class.identifier
        ]
      end

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

  # POST /exam_periods
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

  # PATCH/PUT /exam_periods/1
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

  # PRINT MAP
  def print_map
    @exam_period = ExamPeriod.find(params[:id])

    items = []

    @exam_period.exam_requests
                .includes(:subjects)
                .includes(student: :school_class)
                .find_each do |request|
      school_class = request.student.school_class
      application_shift = request.application_shift

      puts "ALUNO: #{request.student.name} | TURMA: #{school_class.shift} | APLICAÇÃO: #{application_shift} | SAME_SHIFT: #{request.same_shift}"

      request.subjects.each do |subject|
        items << {
          shift: application_shift,
          grade: school_class.grade,
          subject: subject.name
        }
      end
    end

    shift_order = {
      "Manhã" => 1,
      "Tarde" => 2
    }

    @print_map =
      items.group_by { |i| i[:shift] }
           .sort_by { |shift, _| shift_order[shift] || 999 }
           .to_h
           .transform_values do |shift_items|
        shift_items.group_by { |i| i[:grade] }
                   .sort_by { |grade, _| grade_order_value(grade) }
                   .to_h
                   .transform_values do |grade_items|
          grade_items.group_by { |i| i[:subject] }
                     .transform_values(&:count)
        end
      end
  end

  # ATTENDANCE LIST
  def attendance_list
    @exam_period = ExamPeriod.find(params[:id])

    requests = @exam_period
                 .exam_requests
                 .includes(:subjects, student: :school_class)

    @morning_requests = requests
      .select { |r| r.application_shift == "Manhã" }
      .sort_by { |r| [ grade_order_value(r.student.school_class.grade), r.student.name ] }

    @afternoon_requests = requests
      .select { |r| r.application_shift == "Tarde" }
      .sort_by { |r| [ grade_order_value(r.student.school_class.grade), r.student.name ] }
  end

  # DELETE /exam_periods/1
  def destroy
    @exam_period.destroy!

    respond_to do |format|
      format.html { redirect_to exam_periods_path, notice: "Exam period was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_exam_period
    @exam_period = ExamPeriod.find(params[:id])
  end

  def exam_period_params
    params.require(:exam_period).permit(:stage, :exam_type, :active)
  end

  # CENTRAL GRADE ORDER
  def grade_order_value(grade)
    case grade
    when "1º ano" then 1
    when "2º ano" then 2
    when "3º ano" then 3
    when "4º ano" then 4
    when "5º ano" then 5
    when "6º ano" then 6
    when "7º ano" then 7
    when "8º ano" then 8
    when "9º ano" then 9
    when "1ª série" then 10
    when "2ª série" then 11
    when "3ª série" then 12
    else 99
    end
  end
end
