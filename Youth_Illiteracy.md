Gender Illiteracy
================
Shray Dewan
2023-09-03

``` r
gen <- read.csv("~/Documents/GitHub/Youth-Gender-Illiteracy/Data Files/youth_illiteracy (2).csv")
coun <- read.csv("~/Documents/GitHub/Youth-Gender-Illiteracy/Data Files/Gender_StatsCountry.csv")
```

``` r
library(tidyverse)
library(ggplot2)
library(biscale)
library(mapproj)
library(tidyr)
library(reshape)
library(cowplot)
library(dplyr)
library(streamgraph)
library(ggstream)
library(gh)
world_map <- map_data("world")
```

# Choropleth - Illiteracy by Gender

``` r
gen1 <- full_join(gen,world_map,by=c("Country.Name"="region"))
gen1 <- filter(gen1, Indicator.Name == "Youth illiterate population, 15-24 years, % female")
gen_names <- levels(as.factor(gen$Country.Name))
map_names <- levels(as.factor(world_map$region))
#map_names[which( !(map_names %in% gen_names) )]
#gen_names[which( !(gen_names %in% map_names) )]
```

``` r
gen <- mutate(gen,Country.Name=fct_recode(Country.Name,
                                                "Brunei"="Brunei Darussalam",
                                                "Cape Verde"="Cabo Verde",
                                                "Democratic Republic of the Congo"="Congo, Dem. Rep.",
                                                "Republic of Congo"="Congo, Rep.",
                                                "Czech Republic"="Czechia",
                                                "Ivory Coast"="Cote d'Ivoire",
                                                "Egypt"="Egypt, Arab Rep.",
                                                "Swaziland"="Eswatini",
                                                "Gambia"="Gambia, The",
                                                "Iran"="Iran, Islamic Rep.",
                                                "North Korea"="Korea, Dem. People's Rep.",
                                                "South Korea"="Korea, Rep.",
                                                "Kyrgyzstan"="Kyrgyz Republic",
                                                "Laos"="Lao PDR",
                                                "Russia"="Russian Federation",
                                                "Saint Vincent"="St. Vincent and the Grenadines",
                                                "Syria"="Syrian Arab Republic",
                                                "Trinidad"="Trinidad and Tobago",
                                                "Turkey"="Turkiye",
                                                "Venezuela"="Venezuela, RB",
                                                "Yemen"="Yemen, Rep."
                                                ))
gen1 <- full_join(gen,world_map,by=c("Country.Name"="region"))
```

``` r
gen1 <- gen1 %>% drop_na(long)
```

``` r
gen1 <- filter(gen1, Indicator.Name == "Youth illiterate population, 15-24 years, % female")
```

``` r
chor1 <- ggplot(gen1, aes(x=long,y=lat,group=group,fill=last))+ 
  geom_polygon(color="black")+
  geom_polygon(data=filter(gen1,Country.Name=="Lesotho"),color="black")+
  coord_map(xlim=c(-180,180),ylim=c(-55,90))+
  theme_void()+
  labs(title="Illiteracy Proportion by Gender", fill="% Women")
chor1 +
  scale_fill_distiller(palette = "YlOrRd",direction=1)+
  theme(text = element_text(family = "Avenir"),legend.position = "top")
```

![](Youth_Illiteracy_files/figure-gfm/choropleth1-1.png)<!-- -->

# Choropleth 2 - Comparison of Female to Male Youth Illiteracy

``` r
gen2 <- gen
gen2 <- filter(gen2, Indicator.Name == "Youth illiterate population, 15-24 years, female (number)" | Indicator.Name == "Youth illiterate population, 15-24 years, male (number)")
gen2 <- gen2[,c(2,4,56)]
gen2 <- cast(gen2, Country.Name ~ Indicator.Name)
colnames(gen2)[2] ="Female"
colnames(gen2)[3] ="Male"
```

``` r
gen_names <- levels(as.factor(gen2$Country.Name))
map_names <- levels(as.factor(world_map$region))
#map_names[which( !(map_names %in% gen_names) )]
#gen_names[which( !(gen_names %in% map_names) )]
```

``` r
gen2 <- left_join(gen2,world_map,by=c("Country.Name"="region"))
```

``` r
bidata <- bi_class(gen2, x = Female, y = Male, style = "quantile", dim = 3)
bimap <- ggplot() +
  geom_polygon(bidata, mapping = aes(x=long, y=lat, group=group, fill = bi_class), color = "white", size = 0.1, show.legend = F) +
  geom_polygon(data=filter(bidata,Country.Name=="Lesotho"), mapping = aes(x=long, y=lat, group=group, fill = bi_class), color = "white", size = 0.1, show.legend = F) +
  bi_scale_fill(pal = "DkViolet", dim = 3) +
  coord_map(xlim=c(-180,180),ylim=c(-55,90))+
  labs(title = "Comparison of Female to Male Youth Illiteracy",x="",y="") +
  bi_theme(base_family="Avenir", base_size=13)
bilegend <- bi_legend(pal = "DkViolet",
                           dim = 3,
                           xlab = "Female Illiteracy",
                           ylab = "Male Illiteracy",
                           size = 4)
bifinmap <- ggdraw() +
  draw_plot(bimap, 0, 0, 1, 1)+
  draw_plot(bilegend, 0.1, 0.1, 0.2, 0.2)
bifinmap
```

![](Youth_Illiteracy_files/figure-gfm/choropleth2-1.png)<!-- -->

# Streamplot - Illiteracy by Region over Time

``` r
gen3 <- filter(gen, Indicator.Name == "Youth illiterate population, 15-24 years, female (number)")
gen3 <- gen3[-c(1:40),-c(1,3:5,56)]
gen3 <- gather(gen3, Year, Illiterate.Population, X1970:X2019, factor_key=TRUE)
gen3$Year<-as.numeric(gsub("X","",gen3$Year))
gen3 <- na.omit(gen3[!is.na(gen3$Illiterate.Population), ])
```

``` r
gen3.1 <- filter(gen3, Illiterate.Population > 3000000)
```

``` r
coun2 <- coun[c(3,8,9)]
gen3.2 <- mutate(gen3,Country.Name=fct_recode(Country.Name,
                                                "Brunei Darussalam"="Brunei",
                                                "Cabo Verde"="Cape Verde",
                                                "Congo, Dem. Rep."="Democratic Republic of the Congo",
                                                "Congo, Rep."="Republic of Congo",
                                                "Czechia"="Czech Republic",
                                                "Cote d'Ivoire"="Ivory Coast",
                                                "Egypt, Arab Rep."="Egypt",
                                                "Eswatini"="Swaziland",
                                                "Gambia, The"="Gambia",
                                                "Iran, Islamic Rep."="Iran",
                                                "Korea, Dem. People's Rep."="North Korea",
                                                "Korea, Rep."="South Korea",
                                                "Kyrgyz Republic"="Kyrgyzstan",
                                                "Lao PDR"="Laos",
                                                "Russian Federation"="Russia",
                                                "St. Vincent and the Grenadines"="Saint Vincent",
                                                "Syrian Arab Republic"="Syria",
                                                "Trinidad and Tobago"="Trinidad",
                                                "Türkiye"="Turkey",
                                                "Venezuela, RB"="Venezuela",
                                                "Yemen, Rep."="Yemen",
                                              "Côte d'Ivoire" = "Cote d'Ivoire",
                                              "São Tomé and Principe"="Sao Tome and Principe"))
gen3.2 <- left_join(gen3.2,coun2,by=c("Country.Name"="Table.Name"))

gen3.2.1 <- gen3.2 %>%
  group_by(Region, Year) %>%
  summarize(Total.Population = sum(Illiterate.Population))

gen3.2.1 <- na.omit(gen3.2.1)
```

``` r
ggplot(gen3.2.1, aes(x=Year,y=Total.Population,fill=Region)) +
  geom_stream()+
  theme_light()+
  labs(y = "Total Illiterate Youth Population (15-24 years)", 
       title = "Illiterate Youth Population by Region over Time")+
  scale_fill_manual(values = c("#307DC3", "#EBEBEB", "#D6D6D6", "#7ABFFF", "#79F1F8", "#30BBC3"))+
  theme(text = element_text(family = "Avenir"))+
  xlim(1980,2019)+
  annotate("text", label = "South Asia", x=2000, y=0, family = "Avenir", size=8, angle='15')+
  annotate("text", label = "Sub-Saharan Africa", x=2007, y=-27000000, family="Avenir", size=8, angle='25', color="white")+
  annotate("text", label = "East Asia & Pacific", x=1991, y=37000000, family="Avenir", size=8, angle='5', color="white")+
    annotate("text", label = "Middle East & North Africa", x=2000, y=27800000, family="Avenir", size=5, angle='12')+
  annotate("text", label = "Latin America & Caribbean", x=1997, y=31300000, family="Avenir", size=3, angle='14')+
    annotate("text", label = "Europe & Central Asia", x=1984.5, y=27000000, family="Avenir", size=3, angle='0', color="white")+
  annotate("segment", x = 1984, xend = 1985, y = 26200000, yend = 24000000, colour = "#EBEBEB")+
  theme(legend.position = "none")
```

![](Youth_Illiteracy_files/figure-gfm/streamgraph-1.png)<!-- -->
