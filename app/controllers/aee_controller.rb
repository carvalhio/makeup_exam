class AeeController < ApplicationController
  def index
    @students = Student
      .where(aee: true)
      .includes(:school_class)
      .order(:name)

    @school_classes = SchoolClass
      .includes(:students)
      .order(:grade, :identifier, :shift)
  end

  def create
    @test_application = TestApplication.new(test_application_params)

    if @test_application.save
      school_class_ids = params[:school_class_ids] || []

      if params[:class_selection] == "all"
        school_class_ids = SchoolClass.pluck(:id)
      end

      school_class_ids.each do |school_class_id|
        @test_application.test_application_school_classes.create(
          school_class_id: school_class_id
        )
      end

      redirect_to aee_pdf_path(
        @test_application,
        aee: true
      )
    else
      redirect_to aee_path,
        alert: @test_application.errors.full_messages.join(", ")
    end
  end

 def pdf
  @test_application = TestApplication.find(params[:id])

  render pdf: "lista_frequencia_aee_#{@test_application.id}",
         template: "aee/adapted_tests_attendance_pdf",
         formats: [ :html ],
         layout: "pdf",
         disposition: "inline",
         margin: {
           top: 5,
           bottom: 5,
           left: 5,
           right: 5
         }
  end

  private

  def test_application_params
    params.require(:test_application).permit(
      :exam_type,
      :application_date,
      :subject_name,
      :invigilator
    )
  end
end
