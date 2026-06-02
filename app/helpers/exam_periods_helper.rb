module ExamPeriodsHelper
end

def subject_abbreviation(subject_name)
  {
    "Português" => "PORT",
    "Matemática" => "MAT",
    "História" => "HIS",
    "Geografia" => "GEO",
    "Ciências" => "CIE",
    "Arte" => "ART",
    "Literatura" => "LIT",
    "Inglês" => "ING",
    "Redação" => "RED",
    "Física" => "FIS",
    "Química" => "QUI",
    "Biologia" => "BIO",
    "Filosofia" => "FIL",
    "Sociologia" => "SOC"
  }[subject_name] || subject_name.first(4).upcase
end
