require "csv"

namespace :school_classes do
  desc "APAGA TUDO e importa normalizando grade"
  task reset_import: :environment do
    def normalize_grade(raw)
      g = raw.to_s.strip.downcase
      num = g[/\d+/]&.to_i
      return raw if num.nil?

      # se vier com ª ou palavra serie -> ensino médio
      if g.include?("ª") || g.include?("serie") || g.include?("série")
        "#{num}ª série"
      else
        "#{num}º ano"
      end
    end

    def normalize_shift(raw)
      s = raw.to_s.strip.downcase
      return "manhã" if s.start_with?("m")
      return "tarde" if s.start_with?("t")
      return "noite" if s.start_with?("n")
      s
    end

    file_path = ENV["FILE"] || Rails.root.join("db/students.csv")
    puts ">>> Lendo #{file_path}"

    ActiveRecord::Base.transaction do
      puts ">>> Apagando..."
      ExamRequestSubject.delete_all
      ExamRequest.delete_all
      Student.delete_all
      SchoolClass.delete_all

      CSV.foreach(file_path, headers: true, col_sep: ";", encoding: "bom|utf-8") do |row|
        grade_raw = row["grade"]
        identifier = row["identifier"]&.strip
        shift_raw = row["shift"]
        name = row["student_name"]&.strip

        next if grade_raw.blank? || name.blank?

        grade = normalize_grade(grade_raw)
        shift = normalize_shift(shift_raw)

        sc = SchoolClass.find_or_create_by!(grade: grade, identifier: identifier, shift: shift)
        sc.students.create!(name: name)
      end

      puts ">>> OK! Turmas: #{SchoolClass.count} | Alunos: #{Student.count}"
      puts "Grades no banco: #{SchoolClass.pluck(:grade).uniq.inspect}"
    end
  end
end
