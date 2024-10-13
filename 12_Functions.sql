 -- Common Functions in SQL
/*
Defination:
A function is a pre-built actions that performs calculations, manipulate data, and return results.

Some Common Functions (in POSTGRES):
1. String functions - Length(), Trim(), LOWER(), UPPER() {UCASE() in MySQL}, LOCATE(), ascii('char_value'), 
        LEFT('STR', length), RIGHT('STR', length) SUBSTRING('STR', START, LENGTH), REVERSE(), LTRIM(), RTRIM(), FORMAT('0.08','Percent') 
2. Numeric functions CEIL(), COS(), SIN(), FLOOR(), EXP(), GREATEST(), LOG()
3. Statistical functions - avg(), sum(), count(), min(), max(), var()/variance(), stddev()/stddev_pop(), 
        corr(), covar_pop(), percentile_cont()
4. DateTime functions: DATEADD([DAY/MONTH/..], [ValueToAdd], [Date To which to add e.g.'2023-09-01']), DATEDIFF(), DATEPART(), TO_DATE(date, formate), etc.
5. Others: CONCAT(), COALESCE(), CAST()

Usage:
- Used for data manipulation
- Changing values from one to another
- Performing user defined actions 
- retrieving data and summarizing data(e.g. sum(), avg(), etc.)

Syntax:
Syntax 1:
SELECT [function_name([column(s)])]
From tableName;

Syntax 2: Creating custom function
CREATE FUNCTION function_name() RETURNS [return type] AS $$
....SQL Query.....
$$ LANGUAGE SQL;


Code Example:
*/


-- Example 1: Get length of first_name
select first_name, last_name , Length(first_name) as length_fname from customer;

-- Example 2:Example of using String Functions

select substring(first_name, 1, 5) as substring_fname,  -- Starting index is 1, lenght =5
	   LEFT(first_name, 3) as left_fname, -- 3 character from left
	   RIGHT(first_name, 3) as right_fname, -- 3 character from right
       lower(first_name) as lower_fname,  
-- 	   UCASE(first_name) as uppercase_fname, --- this UCASE IN MY SQL FOR UPPER CASE
	   TRIM(first_name) AS trim_fname,
	   reverse(first_name) as reverse_fname,
	   upper(first_name) as upper_fname,
	   ascii(first_name) as ascii_fname --- returns ascii value of first character in first_name
from customer;

-- Example 3: Numeric functions example

select unit_price, 
		CEIL(unit_price) as ceil_price, 
		floor(unit_price) as floor_price,
		EXP(unit_price) as exponential_price,
		SIN(unit_price) as sin_price,
		ROUND(unit_price) as round_price
from product;

--Eample 4: Statistical functions
SELECT avg(unit_price) as avg_price, 
  	   sum(unit_price) as sum_price, 
	   count(unit_price) as count_price, 
	   min(unit_price) as min_price, 
	   max(unit_price) as max_price, 
	   variance(unit_price) as var_price, 
	   stddev_pop(unit_price) as stddev_price
from product;

-- Example 5: Other functions
SELECT CONCAT(name,' ', category_name) as full_name,
	   COALESCE(category_name, 'UNKNOWN_CATEGORY') as coalesce_fname, 
	   CAST(unit_price as varchar) as cast_price
from product;