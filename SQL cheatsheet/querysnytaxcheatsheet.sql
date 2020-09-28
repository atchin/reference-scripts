
-- SQLite syntax cheatsheet cribbed from DataQuest (style guide here: https://www.sqlstyle.guide/) and basic syntax from https://sqlzoo.net/

-- There are FOUR types of SQL commands:
1. Data query language
2. Data definition language
3. Data control language
4. Data manipulation language

database.db

1. ANATOMY OF A DATA QUERY --
-- ALLCAPS and spacing is similar to tidyverse pipeline style conventions; not neccessary but easier to read

SELECT * -- SELECTs some data columns, with aggregate functions
  FROM some_table -- FROM a particular table
    WHERE some_condition -- filters data columns; uses AND, OR, and () for complex queries
  GROUP BY column(s) -- GROUP data BY columns for aggregate data
    HAVING some_condition -- filters resulting aggregate
  ORDER BY column(s) -- ORDER BY a data column
  LIMIT some_limit -- LIMIT table rows
  ; -- ';' signals the end of the query


SELECT *
  FROM some_table
  WHERE some_condition
  ORDER BY some_column
  LIMIT some_limit
  ;


FILTERING BOOLEAN VECTORS --
    WHERE col2 >= 0.5; -- filters data by criteria
                      -- comparison operators: >, <, <=, >=, =, !=
      AND col4 = 'category2'; -- additional filter; AND select for a descriptive variable
      AND col2 < col4 -- can compare columns to other columns
      OR col3 > 0.6 -- an either function; OR a different criteria



COMPLEX LOGIC & LAYERED FILTERS --
-- Parentheses carry conditions over to the next filter
SELECT Major, Major_category, ShareWomen, Unemployment_rate
  FROM recent_grads
    WHERE (Major_category = 'Engineering') --> TRUE OR FALSE
    AND (ShareWomen > 0.5 OR Unemployment_rate < 0.051); --> TRUE OR FALSE
-- the output is all Engineering majors that have mostly female graduates OR an unemployment rate less than 5.1%


ORDERING OUTPUT BY DIFFERENT COLUMNS --
ORDER BY col1; -- orders in ascending order
ORDER BY col1 DESC; -- is DESCending order



AGGREGATE FUNCTIONS/SUMMARY STATISTICS --
-- can call specific summary stats within the SELECT queries
SELECT MIN(col1)
  FROM tabl2; -- this selection returns the summary stats, but not the associated rows
Other aggregate functions:
MAX(), COUNT(), AVG(), SUM()
-- NOTE: use GROUP BY to find summary stats for categories

-- can stack data filters below summary stats
SELECT MAX(col2)
  FROM tabl1
    WHERE col1 = 'category1';

-- report summary stats from multiple columns
SELECT COUNT(*), COUNT(col4)
  FROM tabl1;
-- can use this to search for NULL values within columns since SQL skips NULL values



GROUP BY SUBGROUPING FUNCTIONS --
SELECT <cat1>, AVG(<cat2>) AS avgcat2, <cat3>
  FROM data
  WHERE <cat3> = 'factor1' OR 'factor2'
GROUP BY <cat1> -- calculate aggregated data BY cat1
  HAVING avgcat2 > 0.5 -- a filter for aggregated data
  ;

-- e.g.,
SELECT Species, Station, AVG(ForkLength_mm) AS avgFL,
       MIN(ForkLength_mm) AS minFL, MAX(ForkLength_mm) AS maxFL
  FROM fishData
  GROUP BY Species, Station;



ARITHMETIC FUNCTIONS --
SELECT SUM(ForkLength_mm)/COUNT(ForkLength_mm) AS 'avgLength',
       P25th - P75th AS 'quartilespread'
  FROM trawldata
    WHERE Genus = 'Sebastes' OR 'Ophidon'



CASE CREATING NEW COLUMNS FUNCTIONS --
-- CASE is equivalent to tidyverse::case_when() - create factor/level columns
SELECT <col1>, <col2>, <col3>,
   CASE
     WHEN <condition_1> THEN <value_1>
     WHEN <condition_2> THEN <value_2>
     ELSE <value_3>
     END AS <new_column_name>
   FROM data;
-- e.g.,
SELECT ForkLength_mm, Species, Station,
    CASE
      WHEN ForkLength_mm < 10 THEN 'post-larval'
      WHEN ForkLength_mm > 10 AND ForkLength_mm < 100 THEN 'sub-yearling'
      ELSE 'yearling-plus' -- fall-back value for whatever is left
      END AS Spawner_class -- alias for case column
    FROM fishData;



ALTERING OUTPUT --
-- naming columns and summary stats with queries AKA alias
SELECT ScientificName AS names, ForkLength_mm AS FL,
       Mass_g AS m
  FROM tabl1
    WHERE (name='Sebastes') AND (FL > 150 AND m > 20);

-- use character strings with quotes
SELECT AVG(col2) AS 'avg weight'
  FROM tabl1;

-- ROUND for clarity
SELECT Major_category, Sample_category,
       ROUND(AVG(ShareWomen), 3) AS Mean_women,
       SUM(Total) AS Total_graduates
  FROM new_grads
  GROUP BY Major_category, Sample_category;

-- CAST to transform data
SELECT CAST(SUM(Women) AS Float) / CAST(SUM(Total) AS Float) AS women_ratio -- 'Float' data type that reports decimal numbers
  FROM new_grads
 LIMIT 5;



DISTINCT FUNCTIONS --
SELECT DISTINCT Station
  FROM trawldata;

-- can list several columns to return unique pairings
SELECT DISTINCT Station, DateSampled
  FROM trawldata;

-- reporting multiple DISTINCTs and with aggregate functions
SELECT COUNT(DISTINCT category1) AS unique_cat1,
       COUNT(DISTINCT category2) AS unique_cat2
  FROM tabl1;



STRING FUNCTIONS --
-- 'strings' are the values of text columns

-- LENGTH() function
SELECT ScientificName,
       LENGTH(ScientificName) AS 'length of name' -- returns number of characters in the input strings
  FROM trawldata;

'||' operator concatenates strings
-- can be used to combine string data into a new column
SELECT Genus || Species AS 'Scientific Name'
  FROM data1
--add constant strings to columns
SELECT 'Sebastes' || Species
  FROM data1

-- LOWER() decapitalizes string functions
SELECT 'Major: ' || LOWER(Major) AS Major, Total, Men, Women, Unemployment_rate, LENGTH(Major) AS Length_of_name
  FROM recent_grads
  ORDER BY Unemployment_rate DESC;



2. ANATOMY OF A DATA DEFINITION --
