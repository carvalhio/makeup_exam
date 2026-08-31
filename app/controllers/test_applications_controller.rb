class TestApplicationsController < ApplicationController
  def new
    @test_application = TestApplication.new
    @school_classes = SchoolClass.all
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

      redirect_to test_application_path(@test_application)

    else

      Rails.logger.error(
        "ERROS AO CRIAR TEST APPLICATION:"
      )

      Rails.logger.error(
        @test_application.errors.full_messages
      )

      redirect_to school_classes_path,
        alert: @test_application.errors.full_messages.join(", ")

    end
  end


  def show
    @test_application = TestApplication.find(params[:id])
  end


  def pdf
    @test_application = TestApplication.find(params[:id])

    render pdf: "lista_frequencia_#{@test_application.id}",
           template: "test_applications/pdf",
           formats: [ :html ],
           layout: "pdf",
           disposition: "attachment",
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
      :invigilator,
      :include_aee
    )
  end
end
