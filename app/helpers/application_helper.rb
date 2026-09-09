module ApplicationHelper
  def ordinal_pt(numero, genero = :masc)
    simbolo = genero == :fem ? "ª" : "º"
    # força a renderização como ordinal com sup
    "#{numero}<sup class='ordinal-indicator'>#{simbolo}</sup>".html_safe
  end
end
