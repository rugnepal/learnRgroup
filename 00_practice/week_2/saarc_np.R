library(tidyverse)
library(rvest)
library(jsonlite)
library(stringr)

nepal_url <- "https://nepalcorona.info/api/v1/data/nepal"
nepal_data <- fromJSON(nepal_url, flatten=F, simplifyDataFrame = TRUE)

nepal_data <- nepal_data %>% 
  as.data.frame(stringsAsFactors = F) %>% 
  purrr::map_if(is.data.frame, list) %>% 
  as_tibble() %>% 
  janitor::clean_names()

nepal_data$tested_positive

readr::write_csv(nepal_data, "nepal_data.csv")


################################### SAARC ##################################
saarc_url <- "http://www.covid19-sdmc.org"
saarc_page <- saarc_url %>% read_html() 


saarc_table <- saarc_page %>%
  html_node(xpath = '//*[@id="block-views-situation-highlights-block"]/div/div/div/div/li/div/div[1]/table') %>%
  html_table(fill = F)

saarc_table <- saarc_table[-nrow(saarc_table), ] 

saarc_table$Country <- str_replace(saarc_table$Country, "[0-9]", "")


saarc_table <- saarc_table %>% janitor::clean_names()

# saarc_data <- saarc_table %>% 
# mutate(`Total Cases` = replace(`Total Cases` == 30, NA))


saarc_table[6, 2] <- 30

readr::write_csv(saarc_table, "saarc_data.csv")

# saarc_data <- saarc_table %>% 
#   pivot_longer(cols = 2:3, 
#                names_to = "cases", 
#                values_to = "number")
# 
# 
#   
#   
#   
#   
#   mutate(`Total Cases` = nepal_data$tested_positive)
# 
# # saarc_np
# # 
# # saarc_table %>% merge(saarc_np)
# # 
# 
# 
# 
# 
# 
