class Api::V1::StudentsController < ApplicationController
  def index
    students = Student.all

    render json: students
  end

  def show
    student = Student.find_by(id: params[:id])

    if student
      render json: student, include: :school_class
    else
      render json: { error: "Aluno não encontrado" }, status: :not_found
    end
  end
end
