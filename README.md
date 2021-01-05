# LimpiezaAnalisisDatosUOC
Repositorio con la limpieza y análisis de datos de la práctica 2 de la UOC de la asignatura Tipología y Ciclo de Vida de los Datos del Master de Ciencia de Datos de la UOC

## Miembros del equipo

Sergio Fernández Bertolín

Enrique Javier Andrés Orera


## Descripción de los ficheros


### README.md

Fichero markdown con los contenidos del repositorio y una breve descripción de los archivos


### train.csv

Colección de datos de entrenamiento parte de una competición activa de Kaggle. El objeto de esta competición es la realización de análisis predictivo sobre qué pasajeros sobrevivieron al naufragio del Titanic
https://www.kaggle.com/c/titanic


Tiene el siguiente formato:

| PassengerId | Survived | Pclass |         Name          | Sex | Age | SibSp | Parch | Ticket |  Fare | Cabin | Embarked |
|------------:|---------:|-------:|----------------------:|----:|----:|------:|------:|-------:|------:|------:|---------:|
| 1 | 0 | 3 | Braund, Mr. Owen Harris                             | male   | 22 | 1 | 0 | A/5 21171 | 7.25 | | S |
| 2 | 1 | 1 | Cumings, Mrs. John Bradley (Florence Briggs Thayer) | female | 38 | 1 | 0 | PC 17599  |71.2833|C85| C |



### train_clean.csv

Colección de datos de entrenamiento una vez realizado el proceso de limpieza de los datos

Tiene el siguiente formato:

|FIELD1|PassengerId|Survived|Pclass       |Name                                               |Sex   |Age|SibSp|Parch|Ticket   |Fare   |Cabin|Embarked   |AgeSegments|FamilyMembers|FarePerPassenger|FarePerPassengerSegments|SurvivedInt|
|------|-----------|--------|-------------|---------------------------------------------------|------|---|-----|-----|---------|-------|-----|-----------|-----------|-------------|----------------|------------------------|-----------|
|1     |1          |No      |Tercera clase|Braund, Mr. Owen Harris                            |male  |22 |1    |0    |A/5 21171|7.25   |NA   |Southampton|20-29      |2            |3.625           |[0,64)                  |0          |
|2     |2          |Sí      |Primera clase|Cumings, Mrs. John Bradley (Florence Briggs Thayer)|female|38 |1    |0    |PC 17599 |71.2833|C85  |Cherbourg  |30-39      |2            |35.64165        |[0,64)                  |1          |


### CodePra2.Rmd

Fichero RMarkdown. Solución de la práctica en Rmarkdown


### InformePractica2.pdf

Fichero pdf. Solución de la práctica. Informe en pdf,


### CodePra2.html
Fichero html. Solución de la práctica en html.
