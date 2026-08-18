class AeeController < ApplicationController
  def index
    @students = Student
      .where(aee: true)
      .includes(:school_class)
      .order(:name)
  end
end
