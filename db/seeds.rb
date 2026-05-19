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

puts "Disciplinas cadastradas com sucesso!"