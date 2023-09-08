SELECT *
FROM gender.youth_illiteracy;

-- 2. Shows the female:male youth illiteracy rate (high = bad, low = bad, 1 = equal)
SELECT `Country Name`, ROUND(female_to_male_illiteracy,2) AS female_to_male_illiteracy
FROM (SELECT `Country Name`, `Indicator Name`,`last`, 
LAG(`last`,1) OVER(ORDER BY `Country Name` AND `Indicator Name`)/last AS female_to_male_illiteracy
FROM gender.youth_illiteracy
WHERE `Indicator Name` = "Youth illiterate population, 15-24 years, female (number)" OR 
`Indicator Name` = "Youth illiterate population, 15-24 years, male (number)") AS lag_table
WHERE `Indicator Name` = "Youth illiterate population, 15-24 years, male (number)"
ORDER BY female_to_male_illiteracy DESC;

-- 4. Analyze income group  - high = bad
SELECT b.`Income Group`, ROUND(AVG(a.`last`),2) as Female_Illiteracy
FROM gender.youth_illiteracy as a
INNER JOIN gender.country as b
ON a.`Country Code` = b.`Country Code`
WHERE `Indicator Name` = "Youth illiterate population, 15-24 years, % female"
GROUP BY b.`Income Group`
HAVING `Income Group` IS NOT NULL AND `Income Group` != ''
ORDER BY Female_Illiteracy DESC;

-- 5. Shows that size of illiterate populations change over time (+ = grown, - = shrunk), does not account for pop growth, by group
SELECT `Indicator Name`, ROUND(AVG(((`last`-`1995`)/`1995`))*100,2) AS change_over_time
FROM gender.youth_illiteracy
WHERE `Indicator Name` = "Youth illiterate population, 15-24 years, female (number)" OR 
`Indicator Name` = "Youth illiterate population, 15-24 years, male (number)"
GROUP BY `Indicator Name`
ORDER BY change_over_time DESC;
-- Female youth illiterate population has decreased more than male youth population

-- 6. Shows that size of illiterate populations change over time (+ = grown, - = shrunk), does not account for pop growth, by group and income group
SELECT `Indicator Name`, `Income Group`, ROUND(AVG((`last`-`1995`)/`1995`)*100,2) AS change_over_time
FROM gender.youth_illiteracy as a
INNER JOIN gender.country as b
ON a.`Country Code` = b.`Country Code`
WHERE `Indicator Name` = "Youth illiterate population, 15-24 years, female (number)" OR 
`Indicator Name` = "Youth illiterate population, 15-24 years, male (number)"
GROUP BY `Indicator Name`, `Income Group`
HAVING `Income Group` IS NOT NULL AND `Income Group` != ''
ORDER BY `Income Group`, `Indicator Name` ASC;

-- 7. Shows that size of illiterate populations change over time (+ = grown, - = shrunk), does not account for pop growth, by group and region
SELECT `Indicator Name`, `Region`, ROUND(AVG((`last`-`1995`)/`1995`)*100,2) AS change_over_time
FROM gender.youth_illiteracy as a
INNER JOIN gender.country as b
ON a.`Country Code` = b.`Country Code`
WHERE `Indicator Name` = "Youth illiterate population, 15-24 years, female (number)" OR 
`Indicator Name` = "Youth illiterate population, 15-24 years, male (number)"
GROUP BY `Indicator Name`, `Region`
HAVING `Region` IS NOT NULL AND `Region` != ''
ORDER BY `Region`, `Indicator Name` ASC;



-- APPENDIX

-- assumption: equal populations of genders

-- different indicators
SELECT DISTINCT `Indicator Name`
FROM gender.youth_illiteracy;

-- only select male and female population indicators
SELECT *
FROM gender.youth_illiteracy
WHERE `Indicator Name` = "Youth illiterate population, 15-24 years, female (number)" OR 
`Indicator Name` = "Youth illiterate population, 15-24 years, male (number)";

-- 1. Shows that size of illiterate populations change over time (+ = grown, - = shrunk), does not account for pop growth NOT USE
SELECT `Country Name`, `Indicator Name`, `1995`, `last`, ROUND(((`last`-`1995`)/`1995`),2)*100 AS change_over_time
FROM gender.youth_illiteracy
WHERE `Indicator Name` = "Youth illiterate population, 15-24 years, female (number)" OR 
`Indicator Name` = "Youth illiterate population, 15-24 years, male (number)"
ORDER BY change_over_time DESC;

-- 3. Join to country data, analyze % female illiteracy - high = bad NOT USE
SELECT a.`Country Name`, b.`Region`, b.`Income Group`, a.`last`
FROM gender.youth_illiteracy as a
INNER JOIN gender.country as b
ON a.`Country Code` = b.`Country Code`
WHERE `Indicator Name` = "Youth illiterate population, 15-24 years, % female"
ORDER BY a.`last` DESC;

-- 4. Analyze region  - high = bad NOT USE
SELECT b.`Region`, ROUND(AVG(a.`last`),2) as Female_Illiteracy
FROM gender.youth_illiteracy as a
INNER JOIN gender.country as b
ON a.`Country Code` = b.`Country Code`
WHERE `Indicator Name` = "Youth illiterate population, 15-24 years, % female"
GROUP BY b.`Region`
HAVING `Region` IS NOT NULL AND `Region` != ''
ORDER BY Female_Illiteracy DESC;
