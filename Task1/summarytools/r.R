## Package SummaryTools installieren und mit dem Befehl "library" für dieses R-Dokument nutzen
install.packages('SummaryTools')
library(summarytools)


## Demodaten einlesen und Struktur anzeigen:
happiness <- read.csv("https://raw.githubusercontent.com/lj1337/summarytools/main/world-happiness-report-2021.csv")
str(happiness)


## Werte für "Regional.indicator" anzeigen (Region des Landes):
happiness$Regional.indicator

## Häufigkeitstabellen für alle Werte darstellen (die sich darstellen lassen):
freq(happiness)

## Häufigkeitstabelle für Kontinente:
freq(happiness$Regional.indicator)

## Häufigkeit anzeigen für HTML
freq(happiness$Regional.indicator, plain.ascii = FALSE, style = "rmarkdown")

## Formatieren, Leerzeilen und Platzhalter weglassen
freq(happiness$Regional.indicator, report.nas = FALSE, headings = FALSE)

## Nur erste 5 Countries ausgeben:
freq(happiness$ï..Country.name, order = "freq", rows = 1:5, headings = FALSE)

## View anzeigen von den Regionen
view(freq(happiness$Regional.indicator), collapse = TRUE)


## Kreuztabelle erstellen:
ctable(x = tobacco$smoker, y = tobacco$diseased, prop = "n") ## Proportions: None
ctable(x = tobacco$smoker, y = tobacco$diseased, prop = "r") ## Proportions: Row
ctable(x = tobacco$smoker, y = tobacco$diseased, prop = "c") ## Proportions: Column
ctable(x = tobacco$smoker, y = tobacco$diseased, prop = "t") ## Proportions: Total

## Chi-Squarded Wert mit ausgeben: 
ctable(x = tobacco$smoker, y = tobacco$diseased, prop = "r" , chisq = TRUE) ## TRUE = Signifikanzniveau von 95%. 

## Kreuztabelle ausgeben als HTML Code:
print(ctable(x = tobacco$smoker, y = tobacco$diseased, prop = "r"), method = "render")


##descr() gibt Übersicht über die Werte der Daten (Mean, Standarddeviation, Min, Median, Max, etc)
descr(happiness)

##Nur Teile der Übersicht (common ist vordefiniert, ansonsten einzelne Zeilen eintragen)
descr(happiness, stats = c("common"), transpose = TRUE, headings = FALSE)
descr(happiness, stats = c("mean", "min", "max", "med"), transpose = TRUE, headings = FALSE)


##dfSummary() von allem:
view(dfSummary(happiness))
view(dfSummary(happiness$Ladder.score))

## graph.magnif: Dünnere Balken
view(dfSummary(happiness$Ladder.score, graph.magnif = 0.75))

