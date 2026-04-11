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

# ---- Re-categorización - Capítulo B ----

# Módulo 1 - Infraestructura vial

cap_ab_m1 <- cap_ab %>% mutate(infvi_tv = case_when(infvi_tv == 1 ~ 0.25,
                                                    infvi_tv == 2 ~ 0.75,
                                                    infvi_tv == 3 ~ 0.5,
                                                    infvi_tv == 4 ~ 1),
                               infvi_ev = case_when(infvi_ev == 1 ~ 1,
                                                    infvi_ev == 2 ~ (2/3),
                                                    infvi_ev == 3 ~ (1/3)),
                               infvi_and = case_when(infvi_and == 1 ~ 1,
                                                     infvi_and == 2 ~ 0),
                               infvi_il = case_when(infvi_il == 1 ~ 1,
                                                    infvi_il == 2 ~ 0.5,
                                                    infvi_il == 3 ~ 0))

# Módulo 2 - Calidad interna de la vivienda

cap_ab_m2 <- cap_ab_m1 %>% mutate(cintviv_hp = case_when(cintviv_hp == 1 ~ 1,
                                                         cintviv_hp == 2 ~ 0,
                                                         cintviv_hp == 9 ~ 9),
                                  cintviv_gt = case_when(cintviv_gt == 1 ~ 1,
                                                         cintviv_gt == 2 ~ 0,
                                                         cintviv_gt == 9 ~ 9),
                                  cintviv_gr_tp = case_when(cintviv_gr_tp == 1 ~ 1,
                                                            cintviv_gr_tp == 2 ~ 0,
                                                            cintviv_gr_tp == 9 ~ 9),
                                  cintviv_ft = case_when(cintviv_ft == 1 ~ 1,
                                                         cintviv_ft == 2 ~ 0,
                                                         cintviv_ft == 9 ~ 9),
                                  cintviv_gr_pi = case_when(cintviv_gr_pi == 1 ~ 1,
                                                            cintviv_gr_pi == 2 ~ 0,
                                                            cintviv_gr_pi == 9 ~ 9),
                                  cintviv_crt = case_when(cintviv_crt == 1 ~ 1,
                                                          cintviv_crt == 2 ~ 0,
                                                          cintviv_crt == 9 ~ 9),
                                  cintviv_esc_ven = case_when(cintviv_esc_ven == 1 ~ 1,
                                                              cintviv_esc_ven == 2 ~ 0,
                                                              cintviv_esc_ven == 9 ~ 9),
                                  cintviv_matpar = case_when(cintviv_matpar == 1 ~ 1,
                                                             cintviv_matpar == 2 ~ 7/8,
                                                             cintviv_matpar == 3 ~ 6/8,
                                                             cintviv_matpar == 4 ~ 5/8,
                                                             cintviv_matpar == 5 ~ 4/8,
                                                             cintviv_matpar == 6 ~ 3/8,
                                                             cintviv_matpar == 7 ~ 2/8,
                                                             cintviv_matpar == 8 ~ 1/8,
                                                             cintviv_matpar == 9 ~ 0,))

# Módulo 3

# Módulo 4

# Módulo 5

# Datos adicionales
rm(cap_ab_m1,cap_ab_m2,cap_ab_m3,cap_ab_m4)

# ---- Análisis ausencia de respuesta ----

# Paquete utilizado - Naniar

# ---- Corrección ausencia de respuesta ----
# ---- Diseño de encuesta ----
# ---- Estimaciones ----
# ---- Gráficos ----