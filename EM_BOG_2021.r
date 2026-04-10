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

# ---- Datos ----

# Ruta de datos
setwd("/home/scha/Documentos/Proyectos/EM_Bogota_2021/Data")
# Capítulo A - Identificación
cap_a_id <- read.csv2("CAP_A_Identificación.csv",fileEncoding = "latin1")
# Capítulo B - Datos de la vivenda y su entorno
cap_b_vivenda <- read.csv2("CAP_B_Data_Vivienda.csv",fileEncoding = "latin1")
# Variables
vars <- read.csv2("ICV.csv",fileEncoding = "latin1")

# ---- Selección de variables ----

# Datos de la vivienda y su entorno - Capítulo B
vars_capb <- str_sort(vars$NOMBRE[vars$NOMBRE %in% names(cap_b_vivenda)])
capb_2 <- subset(x = cap_b_vivenda,select = vars_capb)

# Capítulo A y B
cap_ab <- left_join(x = cap_a_id,y = capb_2)
rm(vars_capb,capb_2)

# ---- Renombrar datos ----

names(cap_ab) <- tolower(names(cap_ab))
cap_ab %<>% rename(infvi_tv = nvcbp1,infvi_ev = nvcbp2,infvi_and = nvcbp3,
                   infvi_il = nvcbp5, # Infraestructura vial
                   cintviv_hp = nvcbp8a,cintviv_gt = nvcbp8b,
                   cintviv_gr_tp = nvcbp8c,cintviv_ft = nvcbp8d,
                   cintviv_gr_pi = nvcbp8e,cintviv_crt = nvcbp8f,
                   cintviv_esc_ven = nvcbp8g,cintviv_matpar = nvcbp12,
                   cintviv_matpis = nvcbp13,cintviv_capdis_1 = nvcbp16a1,
                   cintviv_capdis_2 = nvcbp16a2,
                   cintviv_capdis_3 = nvcbp16a3, # Calidad interna de la vivienda
                   rviv_inun = nvcbp8h, rviv_derr = nvcbp8i,
                   rviv_hund = nvcbp8j, # Riesgo de la vivienda
                   servpub_elec = nvcbp11a,servpub_acue = nvcbp11b,
                   servpub_alcan = nvcbp11c,
                   servpub_rbas = nvcbp11d, # Servicios públicos
                   centviv_pert_rui = nvcbp15a,centviv_pert_ea = nvcbp15b,
                   centviv_pert_ins = nvcbp15c,centviv_pert_ca = nvcbp15d,
                   centviv_pert_mao = nvcbp15e,centviv_pert_bas = nvcbp15f,
                   centviv_pert_ep = nvcbp15g,centviv_pert_ani = nvcbp15h,
                   centviv_pert_cca = nvcbp15i,centviv_pert_esc = nvcbp15j,
                   centviv_pert_rb = nvcbp15k,centviv_pert_arb = nvcbp15l,
                   centviv_pert_dh = nvcbp15m, # Entorno de la vivienda - Perturbaciones
                   centviv_cerc_fabind = nvcbp14a,centviv_cerc_basbot = nvcbp14b,
                   centviv_cerc_pmmat = nvcbp14c,centviv_cerc_terbus = nvcbp14d,
                   centviv_cerc_bardis = nvcbp14e,centviv_cerc_ollas = nvcbp14f,
                   centviv_cerc_lbso = nvcbp14g,centviv_cerc_altten = nvcbp14h,
                   centviv_cerc_agures = nvcbp14i,centviv_cerc_incend = nvcbp14j,
                   centviv_cerc_gasol = nvcbp14k, 
                   centviv_cerc_prost = nvcbp14l) # Entorno de la vivienda - Proximidad

# ---- Recategorización ----
# ---- Revisión de respuestas ----

# Paquete utilizado - Naniar

# ---- Diseño de encuesta ----
# ---- Estimaciones ----
# ---- Gráficos ----