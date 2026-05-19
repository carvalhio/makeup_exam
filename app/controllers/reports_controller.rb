class ReportsController < ApplicationController
  def index
    @grouped_data = {}

    ExamRequest.includes(
      :subjects,
      student: :school_class
    ).each do |exam_request|

      school_class = exam_request.student.school_class

      class_key = "#{school_class.grade} - #{school_class.shift}"

      @grouped_data[class_key] ||= Hash.new(0)

      exam_request.subjects.each do |subject|
        @grouped_data[class_key][subject.name] += 1
      end
    end
  end
end