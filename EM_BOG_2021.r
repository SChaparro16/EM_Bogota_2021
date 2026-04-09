# Encuesta multipropósito 2021
# ---- Dependencias ----

# Lectura de archivos
library(readr)
library(readxl)
# Tablas/Estadísticas
library(modelsummary)
library(estimatr)
library(stargazer)
library(kableExtra)
library(e1071)
# Gráficos
library(ggplot2)
# Manipulación de datos
library(dplyr)
library(tidyverse)
# --- library(naniar) - Disponible en Fedora
library(fastDummies)
library(stringr)
library(magrittr)
# ---  library(missForest) - Disponible en Fedora
# Encuestas
# --- library(srvyr) - Disponible en Fedora

# ---- Datos ---- #

# Ruta de datos
setwd("/home/scha/Documentos/Proyectos/EM_Bogota_2021/Data")
# Capítulo A - Identificación
cap_a_id <- read.csv2("CAP_A_Identificación.csv",fileEncoding = "latin1")
# Capítulo B - Datos de la vivenda y su entorno
cap_b_vivenda <- read.csv2("CAP_B_Data_Vivienda.csv",fileEncoding = "latin1")

# ---- Selección de variables ----

# Identificación - Capítulo A

# ---- Diseño de encuesta ----
# ---- Estimaciones ----
# ---- Gráficos ----