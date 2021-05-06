#Marcus Pradel und Alexander Storbeck

#einige Teile des Quellcodes entstammen dem Buch "Data Science Live Book" von Pablo Casas
#bzw. wurden adaptiert

#thefunisreal
#install.packages('funModeling')
#install.packages('dplyr')

library(funModeling)
library(dplyr)

#rm(list = ls())
# Data Profiling 
df_status(heart_disease)

# Bsp. Entfernung der Variablen, die mehr als 60%  Nullen  haben
my_data_status <- df_status(heart_disease, print_results = FALSE)

vars_to_remove <- filter(my_data_status, p_zeros > 60) %>% .$variable
vars_to_remove

heart_disease_2 <- select(heart_disease, -one_of(vars_to_remove))

arrange(my_data_status, -p_zeros) %>% select(variable, q_zeros,p_zeros,)


# Profiling Häufigkeit von kategorischen Variablen
freq(heart_disease, 'thal')     # c('chest_pain','gender')

# Profiling numerische Variablen

profiling_num(heart_disease)

#plot aller numerischen Variablen
profiling_num(heart_disease) %>% select(variable, skewness, kurtosis)
plot_num(heart_disease)
heart_disease$age


#Korellation der numerischen Variablen anzeigen
correlation_table(heart_disease, 'has_heart_disease') 


#Ploting Kategorisch/bins ( autobinning von numerischen Werten)
cross_plot(heart_disease, input = 'chest_pain', target = 'has_heart_disease', plot_type = 'percentual')
#mosaicplot(chest_pain ~ has_heart_disease, data=heart_disease)



#Discretizing von numerischen Variablen
df_status(heart_disease, print_results = F) %>% select(variable, type, unique, q_na) %>% arrange(type)
heart_disease_2 <- heart_disease

heart_disease_2$oldpeak[1:30]=NA

d_bins=discretize_get_bins(data=heart_disease_2, input=c("max_heart_rate", "oldpeak"), n_bins=5)

heart_disease_discretized <- discretize_df(heart_disease_2, data_bins = d_bins, stringsAsFactors = TRUE)

freq(heart_disease_discretized %>% select(max_heart_rate, oldpeak))


#Erkennen von outliers / verschiedene Methoden
tukey_outlier(heart_disease$age)
hampel_outlier(heart_disease$age)

df_status(heart_disease$serum_cholestoral) %>% select(variable, q_na, p_na)

heart_disease$serum_cholestoral <- prep_outliers(heart_disease$serum_cholestoral, 
                                                 type = "set_na", method = "tukey") #method="bottom_top" top_percent = 0.02)

df_status(heart_disease$serum_cholestoral) %>% select(variable, q_na, p_na)


#model performance

#glm model erstellen
fit_glm=glm(has_heart_disease ~ age + oldpeak, data=heart_disease, family = binomial)

#scores/wahrscheinlichkeiten für jede Zeile
heart_disease$score=predict(fit_glm, newdata=heart_disease, type='response')

#Plot Gain und Lift Kurve 
gain_lift(data=heart_disease, score='score', target='has_heart_disease')
