############
#          #
#  visdat  #
#          #
############


#######################################

# Visdat installieren

install.packages("visdat")

# Visdat einbinden

library(visdat)

#######################################

# Wir nutzen die Daten vom Datensatz "typical_data"und "airquality" die mit
# visdat installiert werden

# schauen wir uns die Datenstruktur an

head(typical_data)
str(typical_data)

# Auffälligkeiten? Age -> Chr; Income -> Factor

########################################

# vis_dat()
# Datenstrukturen typologisieren

vis_dat(typical_data)


########################################

# vis_miss()
# Fehlende Daten anzeigen

vis_miss(typical_data)


########################################

# vis_compare()
# Datensatz Veränderung anzeigen

changeddata <- typical_data

changeddata$Age[1:500] # Suchen uns einen Bereich

changeddata$Age[1:500] = 150 # Werte verändern

changeddata$Age[1:500] # Änderungen anzeigen

# Dataframes vergleichen
vis_compare(typical_data, changeddata)


########################################


# vis_expect()
# Bedingungen in Datensätzen vergleichen

vis_expect(changeddata, ~.x >= 180) #z.B. Größe über 180cm

# ~.x setzt die Bedingung


########################################


# vis_cor()
# Stellt Zusammenhänge der Variablen grafisch da

vis_cor(changeddata)  # -> data input can only contain numeric values, please subset the data to the numeric values you would like.

# Nutzung des 2. Datensatzes "airquality"
str(airquality) # Nummerische Daten
vis_cor(airquality)

# pearson: -1 negativer Zusammenhang, 0 kein Zusammenhang, 1 starker Zusammenhang


########################################


# vis_guess()
# beurteilt zu erwartenden Datentyp

vis_guess(airquality)
vis_dat(airquality)

vis_guess(changeddata) # über 1000 wird echt langsam...


########################################

