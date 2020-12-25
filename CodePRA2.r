#1. Descripción del dataset. ¿Por qué es importante y qué pregunta/problema pretende responder?

#El dataset corresponde a una competición activa de Kaggle y el objeto de este es la realización de analisis predictivo sobre que pasajeros sobrevivieron al naufragio del Titanic





#2. Integración y selección de los datos de interés a analizar.

#  Revisión de los datos, extracción visual de información y preparación de los datos

#Carga de los datos:

data.train<-read.csv("./titanic/train.csv",header=T,sep=",")



# Breve análisis de los datos 

# Dimensiones de la base de datos mediante la función dim(). Obtenemos que disponemos de 891 registros o pasajeros (filas) y 12 variables (columnas). 

dim(data.train)


# Examinamos el tipo de datos con los que R ha interpretado cada variable.

sapply(data.train,class)


# Data Dictionary

#PassengerId   id of de passenger
#survival      Survival	0 = No; 1 = Yes
#pclass        Passenger Class	1 = 1st; 2 = 2nd; 3 = 3rd
#name        	First and Last Name	 
#sex	          Sex	 
#age	          Age	 
#sibsp	        Number of Siblings/Spouses Aboard	 
##parch	        Number of Parents/Children Aboard	 
#ticket	      Ticket Number	 
#fare	        Passenger Fare	 
#cabin         Cabin	 
#embarked      Port of Embarkation	C = Cherbourg; Q = Queenstown; S = Southampton



str(data.train)
 

# Buscamos campos nulos
# Examinamos distribución de valores por variables.
# Realizmaos analisis general

summary(data.train)

head(data.train)


#R ha interpretado la variable survival como un entero, la cambiamos a factor

data.train$Survived<- factor(data.train$Survived)
levels(data.train$Survived)
data.train$Survived <- factor(data.train$Survived, levels=c(0,1), labels=c("No", "Sí"))
levels(data.train$Survived )
head(data.train)


#R ha interpretado la variable Pclass como un entero, la cambiamos a factor

data.train$Pclass<- factor(data.train$Pclass)
levels(data.train$Pclass)
data.train$Pclass <- factor(data.train$Pclass, levels=c(1,2,3), labels=c("Primera clase", "Segunda clase", "Tercera clase"))
levels(data.train$Pclass )
head(data.train)



#R ha interpretado la variable Sex como un string, la cambiamos a factor

data.train$Sex<- factor(data.train$Sex)
levels(data.train$Sex)
head(data.train)

#R ha interpretado la variable Cabin como un string, la cambiamos a factor

data.train$Ticket<- factor(data.train$Ticket)
levels(data.train$Ticket)
head(data.train)

# R ha interpretado la variable Cabin como un string, la cambiamos a factor
data.train$Cabin<- factor(data.train$Cabin)
levels(data.train$Cabin)

head(data.train)

sapply(data.train,class)


# "" para Cabin significa valor perdido.

data.train$Cabin[data.train$Cabin==""]<-NA
head(data.train)
sapply(data.train,class)




# R ha interpretado la variable Embarked como un string, la cambiamos a factor

data.train$Embarked<- factor(data.train$Embarked)
levels(data.train$Embarked)
data.train$Embarked<- factor(data.train$Embarked, levels=c("C", "Q", "S"), labels=c("Cherbourg", "Queenstown", "Southampton"))
levels(data.train$Embarked)
head(data.train)
sapply(data.train,class)







#3. Limpieza de los datos


# Números de valores desconocidos por campo

sapply(data.train, function(x) sum(is.na(x)))


#3.1. ¿Los datos contienen ceros o elementos vacíos? ¿Cómo gestionarías cada uno de estos casos?


# Imputación de valores basado en la similitud o diferencia entre los registros: la imputación basada en k vecinos más próximos


# Imputación de valores mediante la función kNN() del paquete VIM
# Estudiar otras opciones de imputación
suppressWarnings(suppressMessages(library(VIM)))
data.train$Age <- kNN(data.train)$Age
data.train$Cabin<- kNN(data.train)$Cabin
data.train$Embarked <- kNN(data.train)$Embarked

summary(data.train)

# ya no tenemos valores vacios
sapply(data.train, function(x) sum(is.na(x)))


# Una vez resuelta la problematica de los valores vacios
# Vemos cómo se distribuyen los valores edad
summary(data.train$Age)

# Discretizamos
data.train$AgeSegments <- cut(data.train$Age, breaks = c(0,10,20,30,40,50,60,70,110), labels = c("0-9", "10-19", "20-29",                               "30-39","40-49","50-59","60-69","70-"))

# Añadimos variable FamilyMembers
data.train$FamilyMembers <- data.train$SibSp + data.train$Parch + 1

# Añadimos variable FarePerPassenger
data.train$FarePerPassenger <- data.train$Fare / data.train$FamilyMembers

 #Analizamos como se relacionan las variables del dataset entre si.

# Survived como función de Sex
ggplot(data = data.train[1:dim(data.train)[1],],aes(x=Sex,fill=Survived))+geom_bar(position="fill")+ylab("Frecuencia")

#Survived como función de Embarked:
ggplot(data = data.train[1:dim(data.train)[1],],aes(x=Embarked,fill=Survived))+geom_bar(position="fill")+ylab("Frecuencia")

#Survived como función de AgeSegments:
ggplot(data = data.train[1:dim(data.train)[1],],aes(x=AgeSegments,fill=Survived))+geom_bar(position="fill")+ylab("Frecuencia")

#Survived como función de Pclass:
ggplot(data = data.train[1:dim(data.train)[1],],aes(x=Pclass,fill=Survived))+geom_bar(position="fill")+ylab("Frecuencia")
head(data.train)

#Survived como función de FamilyMembers:
ggplot(data = data.train[1:dim(data.train)[1],],aes(x=FamilyMembers,fill=Survived))+geom_bar(position="fill")+ylab("Frecuencia")
head(data.train)

#Survived como función de FarePerPassenger:
ggplot(data = data.train[1:dim(data.train)[1],],aes(x=FarePerPassenger,fill=Survived))+geom_bar(position="fill")+ylab("Frecuencia")
head(data.train)


head(data.train)







# 3.2. Identificación y tratamiento de valores extremos.


#2.3.3. Valores extremos

#Representamos un diagrama de caja por cada variable y ver qué valores distan mucho del rango intercuartílico (la caja)


par(mfrow=c(1,5))
boxplot(data.train$Age,main="Age", col="gray")
boxplot(data.train$SibSp,main="Hermanos / cónyuges a bordo", col="gray")
boxplot(data.train$Parch,main="Padres / niños a bordo", col="gray")

boxplot(data.train$Fare,main="Tarifa", col="gray")
boxplot(data.train$FarePerPassenger,main="Tarifa por pasajero", col="gray")

# Utilizamos la función boxplots.stats() de R


boxplot.stats(data.train$Age)$out
boxplot.stats(data.train$SibSp)$out
boxplot.stats(data.train$Parch)$out
boxplot.stats(data.train$Fare)$out

#Outliers Age son casos legítimos tomados de la población correcta, es completamente plausible que viajaran personas de edad avanzada en el Titanic aunque sus edades disten mucho del rango intercuartilico. No procede realizar ningún tratamiento
#Outliers SibSp Apariencia legitima. Coincidencia de apellidos. Coincidencia Ticket. No procede realizar ningún tratamiento. 



head(data.train[data.train$SibSp==8,], 60)


head(data.train[data.train$SibSp==4,], 60)

head(data.train[data.train$SibSp==3,], 60)

#Outliers Parch Apariencia legitima. Coincidencia Ticket.No procede realizar ningún tratamiento. 

head(data.train[data.train$Parch==5,], 60)

head(data.train[data.train$Parch==4,], 60)

head(data.train[data.train$Parch==3,], 60)

#Outliers Fare 
head(data.train[data.train$Fare>=min(boxplot.stats(data.train$Fare)$out),], 60)

#Sospecho del siguiente pasajero
head(data.train[data.train$PassengerId==259,], 60)
#viajaba sola y ocupaba tres cabinas, pero siendo de primera clase pienso que puede ser un outlier legitimo



sapply(data.train,class)



#Exportación de los datos preprocesados


write.csv(data.train, "./titanic/train_clean.csv")
