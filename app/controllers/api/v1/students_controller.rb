class Api::V1::StudentsController < Api::V1::BaseController
  def index
    students = Student.all

    render json: students
  end

 def show
    student = Student.find(params[:id])

    render json: ::StudentSerializer.new(student).as_json
  end

 def create
  student = Student.new(student_params)

  if student.save
    render json: student, status: :created
  else
    render_validation_error(student, "Não foi possível cadastrar o aluno")
  end
end

  def update
    student = Student.find(params[:id])

    if student.update(student_params)
      render json: student
    else
      render_validation_error(student, "Não foi possível atualizar o aluno")
    end
  end

  def destroy
    student = Student.find(params[:id])

    student.destroy

    head :no_content
  end

  private

  def student_params
        params.require(:student).permit(:name, :school_class_id, :aee)
  end
end
