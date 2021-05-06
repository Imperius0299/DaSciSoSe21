
#### R-Code dataMaid Demonstration ###


### Installation des Packets und Einbinden in R ###
install.packages("dataMaid")
library("dataMaid")



### Mitgelieferte Daten Laden und LufthansaCargo-Daten einlesen ###
data(toyData)

library(readxl)
lhc <- read_excel("<Datenpfad_zur_Datei>/LHcargo_FlightSchedule.xlsx")



### Funktion zum Zusammenfassen und Analysieren einzelner Variablen ###
summarize(lhc[, c("RD", "RA", "AL", "STD", "STA", "AGfullname", "ACtype", "Mo")])
summarize(toyData[, c("pill", "events", "region", "change")])



### Funktion zum Visualiseren der einzelnen Variablen und den dazugehoerigen Daten ###
visualize(lhc[, c("RD", "RA", "AL", "STD", "STA", "AGfullname", "ACtype")])
visualize(toyData)



### Funktion zur Ueberpruefung auf Datenqualitaetsprobleme ###
check(lhc[, c("RD", "RA", "AL", "STD", "STA", "AGfullname", "ACtype")])
check(toyData[, c("events", "region", "change")])



### Funktion um einen Report in Form eines Dokumentes zu generieren lassen ###
makeDataReport(lhc[, c("RD", "RA", "AL", "STD", "STA", "AGfullname", "ACtype")], 
               reportTitle = "Lufthansa Cargo Report",                             # Titel des Reportes 
               replace = TRUE,                                                     # erstetzen des zuvor erstellenten Reports
               output = "html")                                                    # Outputtyp geaendert

makeDataReport(toyData, 
               reportTitle = "ToyData Report",   
               ordering = c("alphabetical"),                                       # Sortierung der Variablen im Report selbst
               onlyProblematic = FALSE,                                            # Nur Varibalen einbeziehen, welche Problematisch sein koennten (im Bezug auf die check-Funktion)
               replace = TRUE)



### Uebersicht der einzelnen Funktionen und Beschreibung der einzelnen Analysen ###
allSummaryFunctions()

allVisualFunctions()

allCheckFunctions()




### Darstellung der Wochentage geloest ###
install.packages("plyr")
library(plyr)

Mo <- count(lhc$Mo)
Di <- count(lhc$Tu)
Mi <- count(lhc$We)
Do <- count(lhc$Th)
Fr <- count(lhc$Fr)
Sa <- count(lhc$Sa)
So <- count(lhc$So)

od <- c(Mo$freq[1], Di$freq[1], Mi$freq[1], Do$freq[1], Fr$freq[1], Sa$freq[1], So$freq[1])
od

barplot(od,
        main = "Operation Days",
        xlab = "Occurnes",
        ylab = "Day",
        names.arg = c("Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"),
        col = "darkred")

