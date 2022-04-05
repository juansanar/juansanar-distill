setwd("C:/Users/juansanar/Desktop")

library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(tidytext)

urls_2022_03_31 <- read_csv("urls_2022-03-31.txt", col_names = FALSE)

seq(1, nrow(urls_2022_03_31),2) -> odd_indexes
seq(2, nrow(urls_2022_03_31),2) -> even_indexes

str_detect(urls_2022_03_31$X1[odd_indexes], "http")
which(str_detect(urls_2022_03_31$X1[odd_indexes], "http"))

urls_2022_03_31[79,] <- "Laminar and temporal expression dynamics of coding and noncoding RNAs in the mouse neocortex"

urls_2022_03_31[grepl("//", urls_2022_03_31$X1),] -> links

urls_2022_03_31[-which(grepl("//", urls_2022_03_31$X1)),] -> urls_2022_03_31

df <- cbind(urls_2022_03_31, links)

colnames(df) <- c("url_title", "url")

text_df <- tibble(line = 1:371, text = df$url_title)

text_df %>% unnest_tokens(word, text) -> text_unnested

text_unnested %>%  filter(!word %in% c("the", "and", "of", "in", "a", "to", "for", "1", "2", "at", "is", "are", "as", "b", "an", "on", "i", "by", "e", "it", "its", "etc")) %>% count(word, sort = TRUE) -> text_unnested.filtered

wordcloud::wordcloud(words = text_unnested.filtered$word, freq = text_unnested.filtered$n, min.freq = 1, max.words = 200, random.order = FALSE, rot.per = 0.35, colors = rev(viridis::magma(n = 131100)))
