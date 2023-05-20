/*

We will be working on performing data analysis on the pre-processed data from the previous module 
and conducting Data Analysis using SQL.We will generate queries for given problem statements. 

*/



/*

Find the average age of employees in each department and gender group. 
( Round average age up to two decimal places if needed).

*/


SELECT
	department,
	gender,
	round(avg(age),2) as avg_age
FROM employee
GROUP BY department,gender



/*

List the top 3 departments with the highest average training scores.
( Round average scores up to two decimal places if needed)

*/



SELECT
    department,
    round(avg (avg_training_score),2) as highest_training_score
FROM employee
GROUP BY department
ORDER BY highest_training_score desc
LIMIT 3 


/*

Find the percentage of employees who have won awards in each region. (Round percentages up to two decimal places if needed)

*/


SELECT 
	region,
	round(count(*)*100.0 / (SELECT sum(awards_won) FROM employee),2)  as award_percentage
FROM employee
WHERE awards_won!=0
GROUP BY region


/*

Show the number of employees who have met more than 80% of KPIs for each recruitment channel and education level.

*/

SELECT
    education,
    recruitment_channel,
    count(*) as employee_count
FROM employee
WHERE KPIs_met_more_than_80 >0
GROUP BY recruitment_channel,education


/*

Find the average length of service for employees in each department, 
considering only employees with previous year ratings greater than or equal to 4.
( Round average length up to two decimal places if needed)

*/


SELECT 
    department,
    round(avg(length_of_service),2) AS avg_service_lenght
FROM employee
WHERE previous_year_rating >= 4
GROUP BY department


/*

List the top 5 regions with the highest average previous year ratings.
( Round average ratings up to two decimal places if needed)

*/

SELECT
    region,
    round( avg(previous_year_rating),2) as avg_previous_year_rating
FROM employee
GROUP BY region
ORDER BY avg_previous_year_rating DESC
LIMIT 5


/*

List the departments with more than 100 employees having a length of service greater than 5 years.

*/

SELECT
    department,
    count(*) as no_of_employee
FROM employee
WHERE length_of_service >5
GROUP BY department
HAVING count(*)>100


/*

Show the average length of service for employees who have attended more than 3 training, grouped by department and gender.
( Round average length up to two decimal places if needed)

*/


SELECT
    department,
    gender,
    round(avg(length_of_service),2) as avg_length_of_service
FROM employee
WHERE no_of_trainings >3
GROUP BY department, gender


/*

Find the percentage of female employees who have won awards, per department. 
Also show the number of female employees who won awards and total female employees.
( Round percentage up to two decimal places if needed)

*/

SELECT
    department,
    round(sum(case when gender = 'f' and awards_won >0 then 1 else 0 end ) *100.0 / sum(case when gender = 'f' then 1 else 0 end ) ,2) as female_winner_percentage,
    sum(case when gender ='f' and awards_won = 1 then 1 else 0 end) as female_won_awards,
    sum(case when gender='f'then 1 else 0 end) as total_females_won
FROM employee 
WHERE gender = 'f'
GROUP BY department


/*

Calculate the percentage of employees per department who have a length of service between 5 and 10 years. 
( Round percentage up to two decimal places if needed)

*/

SELECT
    department,
    round(count(case when length_of_service between 5 and 10 then 1 end)/ count(*)*100,2) as service_percentage
FROM employee
GROUP BY department


/*

Find the top 3 regions with the highest number of employees who have met more than 80% of their KPIs and received at least one award,
grouped by department and region.

*/

SELECT
    department,
    region,
    count(*) as no_of_employees
FROM employee
WHERE KPIs_met_more_than_80 >0
and   awards_won >= 1
GROUP BY department, region
ORDER BY no_of_employees DESC
LIMIT 3


/*

Calculate the average length of service for employees per education level and gender,
considering only those employees who have completed more than 2 trainings and have an average training score greater than 75
( Round average length up to two decimal places if needed)

*/

SELECT
    education,
    gender,
    round(avg(length_of_service),2) as avg_service_length
FROM employee
WHERE no_of_trainings> 2
and   avg_training_score> 75
GROUP BY education,gender


/*

For each department and recruitment channel, find the total number of employees who have met more than 80% of their KPIs, 
have a previous_year_rating of 5, and have a length of service greater than 10 years.

*/

SELECT
    department,
    recruitment_channel,
    count(*) as total_employees
FROM employee
WHERE KPIs_met_more_than_80 > 0
and   previous_year_rating =5 
and   length_of_service > 10
GROUP BY department,recruitment_channel


/*

Calculate the percentage of employees in each department who have received awards,
have a previous_year_rating of 4 or 5, and an average training score above 70, grouped by department and gender 
( Round percentage up to two decimal places if needed).

*/

SELECT
    department,
    gender,
round(count(case when awards_won =1 and previous_year_rating in (4,5) and avg_training_score > 70 then 1 end)/count(*)*100,2) as employee_percentage
FROM employee
GROUP BY department,gender



/*

List the top 5 recruitment channels with the highest average length of service for employees
who have met more than 80% of their KPIs, have a previous_year_rating of 5, and an age between 25 and 45 years,
grouped by department and recruitment channel. ( Round average length up to two decimal places if needed).

*/


SELECT 
    department,
    recruitment_channel,
    round(avg(length_of_service),2) as avg_length_service
FROM employee
WHERE KPIs_met_more_than_80 =1
and   previous_year_rating =5 
and   age between 25 and 45 
GROUP BY department, recruitment_channel
ORDER BY avg_length_service DESC
LIMIT 5 






