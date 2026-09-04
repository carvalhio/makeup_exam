require "csv"

# =========================================
# LIMPEZA DOS DADOS ANTIGOS
# =========================================

puts "Limpando dados antigos..."

# Remove as associações das aplicações de testes com as turmas
TestApplicationSchoolClass.delete_all

# Remove as disciplinas vinculadas às solicitações
ExamRequestSubject.delete_all

# Remove as solicitações de 2ª chamada
ExamRequest.delete_all

# Remove todos os alunos
Student.delete_all

# Remove todas as turmas
SchoolClass.delete_all

puts "Dados antigos removidos com sucesso!"

# =========================================
# EXAM PERIODS
# =========================================

stages = [ "1ª Etapa", "2ª Etapa", "3ª Etapa", "4ª Etapa" ]
types  = [ "Parcial", "Global" ]

stages.each do |stage|
  types.each do |exam_type|
    ExamPeriod.find_or_create_by!(
      stage: stage,
      exam_type: exam_type
    ) do |period|
      period.active = true
    end
  end
end

puts "Períodos cadastrados com sucesso!"

# =========================================
# SUBJECTS
# =========================================

subjects = [
  { name: "Língua Portuguesa", code: "PORT" },
  { name: "Matemática", code: "MATE" },
  { name: "História", code: "HIST" },
  { name: "Geografia", code: "GEOG" },
  { name: "Ciências", code: "CIEN" },
  { name: "Biologia", code: "BIOL" },
  { name: "Física", code: "FISI" },
  { name: "Química", code: "QUIM" },
  { name: "Língua Inglesa", code: "INGL" },
  { name: "Língua Espanhola", code: "ESPA" },
  { name: "Redação", code: "REDA" },
  { name: "Arte", code: "ARTE" },
  { name: "Educação Física", code: "EDFI" },
  { name: "Filosofia", code: "FILO" },
  { name: "Sociologia", code: "SOCI" }
]

subjects.each do |subject|
  Subject.find_or_create_by!(
    code: subject[:code]
  ) do |s|
    s.name = subject[:name]
  end
end

puts "Disciplinas cadastradas com sucesso!"


# =========================================
# STUDENTS + SCHOOL CLASSES (CSV)
# =========================================

CSV.foreach(
  Rails.root.join("db/students.csv"),
  headers: true,
  encoding: "bom|utf-8",
  col_sep: ";"
) do |row|
  school_class =
    SchoolClass.find_or_create_by!(
      grade: row["grade"]&.strip,
      identifier: row["identifier"]&.strip,
      shift: row["shift"]&.strip&.capitalize
    )

  Student.find_or_create_by!(
    name: row["student_name"]&.strip,
    school_class: school_class
  )
end

puts "Turmas e alunos importados com sucesso!"
