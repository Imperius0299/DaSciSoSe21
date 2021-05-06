install.packages("arsenal")
library(arsenal)
require(knitr)
require(survival)

#Daten laden

test <- mockstudy  #daten über mediakementenveträglichkeit
test2 <- muck_up_mockstudy()

#tableby

str(test) #Datensatz teilweise nicht vollständig
tab1 <- tableby(arm ~ sex + age, data=test) #arm die Gruppen(x)(hier: die Medikamente), sex+age Werte die zu arm gehören(y)
tab1
summary(tab1, text=TRUE) #stellt die Zusammhänge da in Prozent; A,F,G: Mediakmente; Total
                        #P-Value gibt an wie aussagekräftig die Daten sind (über 0,05 besteht Nullhypthothese -> keinen Zusammenhang, sonst abhänging und alternativhythose gilt)

#tableby mit eigenen labels

mylabels <- list(sex = "Sex, gender", age ="Age, yrs")  #benennen der Tabelle und attributen
summary(tab1, labelTranslations = mylabels, text=TRUE)


tab3 <- tableby(arm ~ sex + age, data=test, test=FALSE, total=FALSE,
                numeric.stats=c("median","q1q3"), numeric.test="kwt") #nun mit Durchschnittswerten, Prozentwerten, sowie Quartile (25 und 75),
                                                                      # zum testen den  Kruskal-Wallis rank sum test
summary(tab3, text=TRUE)


summary(tableby(list(arm, sex) ~ age, data = test, strata = ps), text = TRUE)
tab.test <- tableby(arm ~ kwt(age) + anova(bmi) + kwt(ast), data=test)
tests(tab.test) #p - Values berechnen , mit angebene Methode 
                #(Anova:nur ein test,3 oder mehrer stichproben auf unterschiedliche Mittelwerte -> keine Mittelwertunterscheid bei 0, braucht parameter = hier mann,frau,etc.)
                #(Kruskal-Wallis rank sum test: macht das selbe, unabhängige stichproben, ohne parameter möglich)

#comparedf

summary(comparedf(test, test2, by = "sex")) #läd sehr lange, sehr umfassende auswertung beim Vergleich von 2 Tabellen
#eingrenzbar nach attributen


#write2

install.packages("rmarkdown") #wird benötigt um die Daten zu erstellen
library(rmarkdown)

test
tab3 <- tableby(arm ~ sex + age, data=test)
write2html(tab3, "C:/Users/Paul/OneDrive - hochschule-stralsund.de/Semester 6 WinfB/DataScience/ausgabe.html") #erstellen einer ausgabe

#ebenso möglich mit pdf, word
write2pdf(tab3,"C:/Users/Paul/OneDrive - hochschule-stralsund.de/Semester 6 WinfB/DataScience/ausgabe.pdf") #benötigt pakete die in meiner r version nicht verfügbar sind
write2word(tab3,"C:/Users/Paul/OneDrive - hochschule-stralsund.de/Semester 6 WinfB/DataScience/ausgabe.doc") #auch für alte Word Versionen
write2word(tab3,"C:/Users/Paul/OneDrive - hochschule-stralsund.de/Semester 6 WinfB/DataScience/ausgabe.docx")


install.packages("pdfcrop") #für write2pdf
install.packages("ghostcript")

