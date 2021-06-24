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
library(dplyr)

victims_sq_demo <- read.csv('data/victims_sq_demo.csv')

victims_sq_demo <- victims_sq_demo %>%
  mutate(doi = as_date(doi.x,format = '%Y-%m-%d'))%>%
  mutate(sq = as.integer(sq))

victims_sq_demo_unique <- victims_sq_demo %>%
  select(victim,doi,victim_race,victim_gender,victim_age,Armed.Unarmed.Status,sq,Latitude,Longitude
         ,URL.of.image.of.victim,A.brief.description.of.the.circumstances.surrounding.the.death,
         Link.to.news.article.or.photo.of.official.document)%>%
  mutate(description = A.brief.description.of.the.circumstances.surrounding.the.death)%>%
  mutate(link = Link.to.news.article.or.photo.of.official.document)%>%
  mutate(URL.of.image.of.victim = case_when(victim == 'George Floyd' ~ 'https://ichef.bbci.co.uk/news/976/cpsprodpb/13278/production/_112565487_floyd.png',
                                            victim != 'George Floyd' ~ URL.of.image.of.victim))%>%
  unique()











