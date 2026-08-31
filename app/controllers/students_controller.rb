class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]

  # GET /students or /students.json
  def index
    students =
      Student.where(
        school_class_id: params[:school_class_id]
      ).order(:name)

    render json: students.map { |student|
      {
        id: student.id,
        name: student.name,
        has_request: ExamRequest.exists?(
          exam_period_id: params[:exam_period_id],
          student_id: student.id
        )
      }
    }
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html {
          redirect_to school_class_path(@student.school_class_id),
          notice: "Aluno cadastrado com sucesso!",
          status: :see_other
        }

        format.json {
          render :show,
          status: :created,
          location: @student
        }
      else
        format.html {
          redirect_to school_class_path(@student.school_class_id),
          alert: "Não foi possível cadastrar o aluno."
        }

        format.json {
          render json: @student.errors,
          status: :unprocessable_content
        }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      @student.assign_attributes(student_params)

      if @student.save
        # Pega a posição do aluno na ordem alfabética
        students_ordered = @student.school_class.students.order(:name).to_a
        @student_index = students_ordered.index(@student) + 1

        format.html {
          redirect_to school_class_path(@student.school_class_id),
          notice: "Aluno atualizado com sucesso!",
          status: :see_other
        }

        format.turbo_stream

        format.json {
          render :show,
          status: :ok,
          location: @student
        }
      else
        format.html {
          render :edit,
          status: :unprocessable_content
        }

        format.json {
          render json: @student.errors,
          status: :unprocessable_content
        }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
  school_class_id = @student.school_class_id

  @student.destroy!

  respond_to do |format|
    format.html {
      redirect_to school_class_path(school_class_id),
      notice: "Aluno excluído com sucesso!",
      status: :see_other
    }

    format.json {
      head :no_content
    }
  end
end

  private

  # Use callbacks to share common setup between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(
      :name,
      :school_class_id,
      :aee
    )
  end
end
