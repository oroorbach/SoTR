

## Bringing in MK continuous data to show variation in DO - especailly the anoxic times

# load_R first 
# 
here::here('data')

##WORKS
do <- readxl::read_xlsx(here::here('data', "gtmmkwq2021Q4.xlsx" ), 
                         sheet = 'Data') %>% 
  janitor::clean_names()


##check dat for NA or BLANKS ?? I have quite a few??
View(do %>% dplyr::filter(is.na(do_mgl)))

## remove NA files
do2 <- do %>% dplyr::filter(do_mgl != "NA")


mk_DO <- do2 %>%
  select(date_time_stamp,
         do_mgl,
         do_pct)

DO_plot <- mk_DO %>%
          ggplot(aes(x = date_time_stamp, y = do_mgl)) +
          geom_point(aes(color = do_mgl <= 2), size = 0.5) +
          geom_hline(yintercept = 2) + 
          scale_color_manual(name = "Hypoxia \nThreshold \n2 mg/L",
                     labels = c("Above", "Below"),
                     values = c('grey62', 'red')) +
          scale_y_continuous(expand = c(0,0), breaks = seq(0,14, by = 2)) +
          theme_classic() +
          theme(axis.text = element_text(color = 'black')) +
          labs(x = "",
               y = "Dissolved Oxygen (mg/L)")

ggsave(DO_plot,
       filename = here('output', 'DO_plot_MK.png'))

