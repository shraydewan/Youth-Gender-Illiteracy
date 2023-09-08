# Youth and Gender Global Illiteracy

This project analyzes global youth illiteracy across genders (binary representation), regions, and countries. Data courtesy of The World Bank.

It primarily uses two programs:

1. SQL - Data analysis
2. R - Data visualization


**SQL**

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

3. Not accounting for population growth, how has the size of illiterate populations changed over time?

Indicator Name | change_over_time
--- | ---
Male | -10.79
Female | -33.19

4. Not accounting for population growth, how has the size of illiterate populations changed over time by country income bracket?

Indicator Name | Income Group | change_over_time
--- | --- | ---
Female | High income | -45.37
Male | High income | -34.72
Female | Low income | 28.65
Male | Low income | 55.15
Female | Lower middle income | -26.36
Male | Lower middle income | 9.37
Female | Upper middle income | -48.85
Male | Upper middle income | -21.55


**R**

![alt text](https://github.com/shraydewan/Youth-Gender-Illiteracy/blob/main/choropleth1-1.png.jpg?raw=true)









