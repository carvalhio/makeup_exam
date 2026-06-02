module ExamPeriodsHelper
  def subject_abbreviation(name)
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
    }[name] || name.first(4).upcase
  end
end
