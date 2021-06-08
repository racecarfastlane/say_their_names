library(shiny)
library(ggplot2)
library(plotly)
library(extrafont)
require(scales)
library(colorspace)
library(ggiraph)
library(RColorBrewer)
library(leaflet)
library(lubridate)

victims_article_merge <- read.csv("data/victims_article_freq.csv")
victims_sq <- read.csv('data/victims_sq.csv')
victims_geo <- read.csv('data/victims_geo.csv')
victims_sq_demo <- read.csv('data/victims_sq_demo.csv')

victims_sq_demo <- victims_sq_demo %>%
  mutate(doi = as_date(doi,format = '%Y-%m-%d'))%>%
  mutate(sq = as.integer(sq))

victims_sq_demo_unique <- victims_sq_demo %>%
  select(victim,doi,victim_race,victim_gender,victim_age,Armed.Unarmed.Status,sq,Latitude,Longitude
         ,URL.of.image.of.victim)%>%
  unique()











