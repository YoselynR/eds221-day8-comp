library(tidyverse)
library(patchwork)
library(here)

lizards<-read_csv(here("data_tidy","lizards.csv"))

two_lizards<-lizards%>%
  filter(common_name%in%c("eastern fence","western whiptail"))
#legend and labels for variable colors, save
p1<-ggplot(two_lizards,aes(x=total_length,y=weight))+
  geom_point(aes(color=common_name))+
  scale_color_manual(values = c("orange","navy"),
                     name = "Lizard species:",
                     labels = c("Eastern fence lizard",
                                "Western whiptail lizard"))+
  theme(legend.position = c(0.2,0.8),
        legend.background = element_blank())
#save
p2<-ggplot(lizards,aes(x=weight,y=site))+
  geom_boxplot()+
  labs(x="Weight (grams)",
       y="Site")
#save
p3<-ggplot(lizards,aes(x=weight))+
  geom_histogram()+
  labs(x="Weight (grams)",
       y="Counts (n)")
#save graphs side by side + or on top /
p4<-((p1+p2)/p3) & theme_minimal()

ggsave("patchwork-example.png",p4)

