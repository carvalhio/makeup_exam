class ExamRequestsController < ApplicationController
  before_action :set_exam_period
  before_action :set_exam_request, only: %i[show edit update destroy]
  before_action :load_exam_menu


 # GET /exam_requests
 def new
  last_date =
    @exam_period
      .exam_requests
      .where.not(application_date: nil)
      .order(application_date: :desc)
      .pick(:application_date)

  @exam_request =
    @exam_period.exam_requests.new(
      student_id: params[:student_id],
      application_date: params[:application_date].presence || last_date
    )
  end

  # GET /exam_requests/1
  def show
    if @exam_period.exam_type == "Global"
      @selected_global_areas =
        selected_global_areas(@exam_request)
    end
  end

  # GET /exam_requests/1/edit
  def edit
    if @exam_period.exam_type == "Global"
      @selected_global_areas =
        selected_global_areas(@exam_request)
    end
  end

  # POST /exam_requests
  def create
    @exam_request =
      @exam_period.exam_requests.new(exam_request_params)

    if @exam_period.exam_type == "Global"
      @exam_request.subject_ids = global_subject_ids
    end

    if @exam_request.save
      redirect_to exam_period_path(@exam_period),
                  notice: "Inserido com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exam_requests/1
  def update
  attributes = exam_request_params

  if @exam_period.exam_type == "Global"
    attributes[:subject_ids] = global_subject_ids
  end

  respond_to do |format|
    if @exam_request.update(attributes)
      format.html {
        redirect_to exam_period_path(@exam_period
        ),
        notice: "Atualizado com sucesso",
        status: :see_other
      }

      format.json {
        render :show,
               status: :ok,
               location: @exam_request
      }
    else
      format.html {
        render :edit,
               status: :unprocessable_entity
      }

      format.json {
        render json: @exam_request.errors,
               status: :unprocessable_entity
      }
    end
  end
end

# DELETE /exam_requests/1
def destroy
  @exam_request.destroy

  redirect_to exam_period_path(@exam_period),
              notice: "Deletado com sucesso!"
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

  def find_or_redirect
  exam_request = ExamRequest.find_by(
    exam_period_id: params[:exam_period_id],
    student_id: params[:student_id]
  )

  if exam_request
    redirect_to edit_exam_period_exam_request_path(
      params[:exam_period_id],
      exam_request
    )
  else
      redirect_to new_exam_period_exam_request_path(
      params[:exam_period_id],
      student_id: params[:student_id],
      application_date: params[:application_date]
    )

  end
end

  private
  def load_exam_menu
     @exam_menu = ExamPeriod
    .select(:id, :stage, :exam_type)
    .order(:stage)

  @exam_menu_grouped = @exam_menu.group_by(&:stage)
  end

  def set_exam_request
    @exam_request = @exam_period.exam_requests.find(params[:id])
  end

  def set_exam_period
    @exam_period = ExamPeriod.find(params[:exam_period_id])
  end

  def global_subject_ids
    return [] unless params[:global_areas]

    groups = {
      "linguagens" => [
        "Língua Portuguesa",
        "Língua Inglesa",
        "Língua Espanhola",
        "Literatura",
        "Arte"
      ],

      "natureza" => [
        "Biologia",
        "Física",
        "Química"
      ],

      "matematica" => [
        "Matemática"
      ],

      "humanas" => [
        "História",
        "Geografia",
        "Filosofia",
        "Sociologia"
      ],

      "redacao" => [
        "Redação"
      ],

      "ed_fisica" => [
        "Educação Física"
      ]
    }

    selected_names =
      params[:global_areas].flat_map do |area|
        groups[area] || []
      end

      Subject.where(name: selected_names).pluck(:id)
  end

  def selected_global_areas(exam_request)
  names = exam_request.subjects.pluck(:name)

  areas = []

  areas << "linguagens" if (
    names & [
      "Língua Portuguesa",
      "Língua Inglesa",
      "Língua Espanhola",
      "Literatura",
      "Arte"
    ]
  ).any?

  areas << "natureza" if (
    names & [
      "Biologia",
      "Física",
      "Química"
    ]
  ).any?

  areas << "matematica" if names.include?("Matemática")

  areas << "humanas" if (
    names & [
      "História",
      "Geografia",
      "Filosofia",
      "Sociologia"
    ]
  ).any?

  areas << "redacao" if names.include?("Redação")

  areas << "ed_fisica" if names.include?("Educação Física")

  areas
  end
  def exam_request_params
    params.require(:exam_request).permit(
      :student_id,
      :exam_period_id,
      :application_date,
      :same_shift,
      :reason,
      :reason_description,
      subject_ids: []
    )
  end
end
