install.packages("inspectdf")
install.packages('vctrs')

library(inspectdf)
library(dplyr)

data(starwars, package = "dplyr")
data(storms, package = "dplyr")

---------------------------------------------
  
#inspect_cat()
# Zusammenfassung und Vergleich der Ebenen in kategorialen Spalten 
  
# Zusammenfassung einzelner Datenrahmen
inspect_cat(starwars)

# Gepaarter Datenrahmenvergleich
inspect_cat(starwars, starwars[1:20, ])

# In Levels finden sich vollständige Listen der Ebenen und der Häufigkeit des Auftretens, sprich die Tabellen dazu
a <- starwars %>% inspect_cat()
a
a %>% show_plot()

# Kardinalität 1 bewirkt, dass alle Einträge mit Häufigkeit 1 in eine Rubkrik zusammengefasst werden 
a %>% show_plot(high_cardinality = 1)

---------------------------------------------
  
#inspect_cor()
# Ordentliche Korrelationskoeffizienten für numerische Datenrahmenspalten  
# ursprünglich cor() <- benötigt jedoch numerische Daten verarbeiten 
cor(storms)
# cor() kann nicht bei Eingabe von 2 Typen (chr,int) nur die numerischen herausfiltern
cor(storms %>% select_if(is.numeric))
# cor() gibt matrizen aus - gut für lineare Algebra, jedoch schlecht für Visualität
    
#inspect_cor bietet viel Visualität 
b <- storms %>% inspect_cor()
b
b %>% show_plot()

---------------------------------------------
  
# Zusammenfassung und Vergleich der häufigsten Ebenen in kategorialen Spalten 
#inspect_imb()

inspect_imb(starwars)

# Vergleich von 2 Datenrahmen
inspect_imb(starwars, starwars[1: 30, ])

# Zusammenfassung von geordneten Datenrahmen
starwars %>% group_by(gender) %>% inspect_imb()

---------------------------------------------
  
# Zusammenfassung und Vergleich der Speichernutzung von Datenrahmenspalten
# inspect_mem()  
# Veranschaulichung was am meisten Speicher nutzt
c <- inspect_mem(starwars)
c
# Vergleich von 2 Datenrahmen im Bezug auf Speichernutzung
inspect_mem(starwars, starwars[1:40, ])

starwars %>% group_by(species) %>% inspect_mem()

c %>% show_plot()

---------------------------------------------
  
#inspect_na()
# Zusammenfassung und Vergleich der fehlenden Rate über Datenrahmenspalten hinweg
# head() zeigt, dass einige Angaben fehlen 
head(starwars)

#inspect_na() gibt an wo wievele Angaben fehlen
d <- starwars %>% inspect_na
d
d %>% show_plot()
starwars %>% inspect_na %>% show_plot()

#Beispiel für Vergleichende Datenrahmen
inspect_na(starwars, starwars[1:20, ])

---------------------------------------------

#inspect_num()
# Zusammenfassung und Vergleich von numerischen Spalten
# Gibt statistische Daten aus 
e <- inspect_num(starwars)
e
# Vergleich der statistischen Daten 
inspect_num(starwars, starwars[1:25, ])

# nach "Gender" sortierte Datenausgabe
starwars %>% group_by(gender) %>% inspect_num()

# die Histogramme - muss nicht gezeigt werden
e %>% show_plot()

---------------------------------------------
  
#inspect_types()  
# Zusammenfassung und Vergleich der Spaltentypen  

# gibt Datentypen aus  
f <- inspect_types(starwars)
f

f %>% show_plot()
