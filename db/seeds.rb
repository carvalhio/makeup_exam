stages = ["1ª Etapa", "2ª Etapa", "3ª Etapa", "4ª Etapa"]
types  = ["Parcial", "Global"]

stages.each do |stage|
  types.each do |exam_type|
    ExamPeriod.create!(
      stage: stage,
      exam_type: exam_type,
      active: true
    )
  end
end

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
  Subject.find_or_create_by!(code: subject[:code]) do |s|
    s.name = subject[:name]
  end
end

school_classes = [
  ["1º ano", "A", "Manhã"],
  ["1º ano", "B", "Manhã"],
  ["1º ano", "C", "Manhã"],

  ["2º ano", "A", "Manhã"],
  ["2º ano", "B", "Manhã"],
  ["2º ano", "C", "Manhã"],

  ["3º ano", "A", "Manhã"],
  ["3º ano", "B", "Manhã"],
  ["3º ano", "C", "Tarde"],

  ["4º ano", "A", "Manhã"],
  ["4º ano", "B", "Manhã"],

  ["5º ano", "A", "Manhã"],
  ["5º ano", "B", "Manhã"],
  ["5º ano", "C", "Tarde"],

  ["6º ano", "A", "Manhã"],
  ["6º ano", "B", "Manhã"],
  ["6º ano", "C", "Tarde"],

  ["7º ano", "A", "Manhã"],
  ["7º ano", "B", "Manhã"],
  ["7º ano", "C", "Tarde"],

  ["8º ano", "A", "Manhã"],
  ["8º ano", "B", "Manhã"],
  ["8º ano", "C", "Manhã"],
  ["8º ano", "D", "Tarde"],

  ["9º ano", "A", "Manhã"],
  ["9º ano", "B", "Manhã"],
  ["9º ano", "C", "Manhã"],
  ["9º ano", "D", "Tarde"],

  ["1ª série", "A", "Manhã"],
  ["1ª série", "B", "Manhã"],
  ["1ª série", "C", "Manhã"],

  ["2ª série", "A", "Manhã"],
  ["2ª série", "B", "Manhã"],
  ["2ª série", "C", "Manhã"],

  ["3ª série", "A", "Manhã"],
  ["3ª série", "B", "Manhã"]
]

school_classes.each do |grade, identifier, shift|
  SchoolClass.find_or_create_by!(
    grade: grade,
    identifier: identifier,
    shift: shift
  )
end

puts "Turmas cadastradas com sucesso!"

