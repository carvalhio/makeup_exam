
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
        students = school_class.students

        regular = students.where(aee: false).count
        aee = students.where(aee: true).count

        {
          identifier: school_class.identifier,
          shift: school_class.shift,
          regular: regular,
          aee: aee,
          regular_ing: students.where(
            aee: false,
            foreign_language: "ing"
          ).count,
          regular_esp: students.where(
            aee: false,
            foreign_language: "esp"
          ).count,
          aee_ing: students.where(
            aee: true,
            foreign_language: "ing"
          ).count,
          aee_esp: students.where(
            aee: true,
            foreign_language: "esp"
          ).count
        }
      end

      morning_classes = classes.select do |school_class|
        school_class[:shift] == "Manhã"
      end

      afternoon_classes = classes.select do |school_class|
        school_class[:shift] == "Tarde"
      end

      morning = morning_classes.sum do |school_class|
        school_class[:regular]
      end

      afternoon = afternoon_classes.sum do |school_class|
        school_class[:regular]
      end

      aee = classes.sum do |school_class|
        school_class[:aee]
      end

      {
        grade: grade,
        morning: morning,
        afternoon: afternoon,
        aee: aee,
        total: morning + afternoon + aee,
        classes: classes,

        regular_ing_morning: morning_classes.sum do |school_class|
          school_class[:regular_ing]
        end,

        regular_esp_morning: morning_classes.sum do |school_class|
          school_class[:regular_esp]
        end,

        regular_ing_afternoon: afternoon_classes.sum do |school_class|
          school_class[:regular_ing]
        end,

        regular_esp_afternoon: afternoon_classes.sum do |school_class|
          school_class[:regular_esp]
        end,

        aee_ing: classes.sum do |school_class|
          school_class[:aee_ing]
        end,

        aee_esp: classes.sum do |school_class|
          school_class[:aee_esp]
        end
      }
    end
  end
end
