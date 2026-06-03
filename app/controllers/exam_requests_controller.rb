class ExamRequestsController < ApplicationController
  before_action :set_exam_period
  before_action :set_exam_request, only: %i[show edit update destroy]
  before_action :load_exam_menu


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
      redirect_to exam_period_path(@exam_period),
            notice: "Inserido com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exam_requests/1
  def update
  respond_to do |format|
    if @exam_request.update(exam_request_params)

      format.html do
        redirect_to exam_period_path(@exam_period),
                    notice: "Solicitação atualizada com sucesso",
                    status: :see_other
      end

      format.json do
        render :show,
               status: :ok,
               location: exam_period_exam_request_path(@exam_period, @exam_request)
      end

    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @exam_request.errors, status: :unprocessable_entity }
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
      student_id: params[:student_id]
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

  def exam_request_params
    params.require(:exam_request).permit(
      :student_id,
      :exam_period_id,
      :same_shift,
      :reason,
      :reason_description,
      subject_ids: []
    )
  end
end
