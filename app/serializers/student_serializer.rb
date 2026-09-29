class StudentSerializer
  def initialize(student)
    @student = student
  end

  def as_json
    {
      id: @student.id,
      name: @student.name,
      aee: @student.aee,
      school_class: {
        grade: @student.school_class.grade,
        identifier: @student.school_class.identifier,
        shift: @student.school_class.shift
      }
    }
  end
end
