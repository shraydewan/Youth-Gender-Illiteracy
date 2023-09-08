# Youth and Gender Global Illiteracy

This project analyzes global youth illiteracy across genders (binary representation), regions, and countries. Data courtesy of The World Bank.

It primarily uses two programs:

1. SQL - Data analysis
2. R - Data visualization


## SQL

1. What are the five countries with the highest female:male youth illiteracy rate?

Country Name | female_to_male_illiteracy
--- | ---
Bahrain | 22.04
Turkiye | 4.34
Libya | 3.82
Kazakhstan | 2.38
Israel | 1.97

2. How does the youth illiterate population that is female vary across country's income brackets?

Income Group | female_illiteracy
--- | ---
Low income | 56.34
Lower middle income | 49.72
High income | 44.79
Upper middle income | 43.37

3. Not accounting for population growth, how has the size of illiterate populations changed between 1995 and now?

Indicator Name | change_over_time (%)
--- | ---
Male | -10.79
Female | -33.19

4. Not accounting for population growth, how has the size of illiterate populations changed between 1995 and now (by country income bracket)?

Indicator Name | Income Group | change_over_time (%)
--- | --- | ---
Female | High income | -45.37
Male | High income | -34.72
Female | Low income | 28.65
Male | Low income | 55.15
Female | Lower middle income | -26.36
Male | Lower middle income | 9.37
Female | Upper middle income | -48.85
Male | Upper middle income | -21.55


## R

1. How much of the illiterate youth population in each country is female?

![alt text](https://github.com/shraydewan/Youth-Gender-Illiteracy/blob/main/Figures/choropleth1-1.png)

2. Which countries have more illiterate young women compared to men? Illiterate young men to women?

![alt text](https://github.com/shraydewan/Youth-Gender-Illiteracy/blob/main/Figures/choropleth2-1.png)

3. Not accounting for population growth, how has the total illiterate population of the world changed over time?

![alt text](https://github.com/shraydewan/Youth-Gender-Illiteracy/blob/main/Figures/streamgraph-1.png)


