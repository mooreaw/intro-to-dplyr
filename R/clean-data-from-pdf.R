
library(tidyverse)

bf <- read_lines("./data/rentfrow-2013-aggregate-p-scores-by-state.txt")

bf_clean <- tibble(
  state = bf %>% str_remove_all("[0-9]|,|\\.") %>% str_squish(),
  pdata = bf %>%
    str_remove_all("[A-Z]|[a-z]") %>%
    str_squish() %>%
    str_split(" ") %>%
    map(parse_number) %>%
    map(set_names, c("sample_size", "t_e", "t_a", "t_c", "t_n", "t_o"))
)

bf_clean <- unnest_wider(bf_clean, col = pdata)

write_csv(bf_clean, "./data/rentfrow-2013-bf-states-clean.csv")
