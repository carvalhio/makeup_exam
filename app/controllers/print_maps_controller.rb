class PrintMapsController < ApplicationController
  def index
    @print_map = build_print_map
  end

  def pdf
    @print_map = build_print_map

    render pdf: "mapa_de_impressao_testes",
          template: "print_maps/index",
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

  def build_print_map
    grades = SchoolClass
      .distinct
      .pluck(:grade)

    grades.map do |grade|
      school_classes = SchoolClass
        .where(grade: grade)
        .includes(:students)
        .order(:shift, :identifier)

      classes = school_classes.map do |school_class|
        regular = school_class.students
          .where(aee: false)
          .count

        aee = school_class.students
          .where(aee: true)
          .count

        {
          identifier: school_class.identifier,
          shift: school_class.shift,
          regular: regular,
          aee: aee
        }
      end

      morning = classes
        .select { |school_class| school_class[:shift] == "Manhã" }
        .sum { |school_class| school_class[:regular] }

      afternoon = classes
        .select { |school_class| school_class[:shift] == "Tarde" }
        .sum { |school_class| school_class[:regular] }

      aee = classes.sum { |school_class| school_class[:aee] }

      {
        grade: grade,
        morning: morning,
        afternoon: afternoon,
        aee: aee,
        total: morning + afternoon + aee,
        classes: classes
      }
    end
  end
end
