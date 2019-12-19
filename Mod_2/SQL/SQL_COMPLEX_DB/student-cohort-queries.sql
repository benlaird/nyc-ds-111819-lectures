SELECT * FROM students.students;


-- Which 3 students have lived in NYC the shortest amount of time?
select * from students.students order by years_in_nyc asc limit 3;

-- How many students are native New Yorkers?
select * from students.students where birthplace like '%NY%' or birthplace like '%New York%';

select s.name, datediff(curdate(),  s.dob) / 365 as age_in_years, s.years_in_nyc, 
		datediff(curdate(),  s.dob) / 365 - s.years_in_nyc as diff
         from students.students s order by
        ((datediff(curdate(),  s.dob) / 365) - s.years_in_nyc) asc;
        
-- Number of years between dob and curdate()
select s.name, datediff(curdate(),  s.dob) / 365 as age_in_years 
         from students.students s order by
        (datediff(curdate(),  s.dob) / 365) asc;

select average(datediff(curdate(),  s.dob) / 365 as age_in_years)
         from students.students s;

-- Do any two students have the same favorite food?
select fav_food, count(*) from students.students group by fav_food having count(*) > 1;

-- Jackson Gilkey soln:
SELECT name, fav_food FROM students.students s1 WHERE fav_food IN(
                SELECT fav_food
                FROM students.students s2
                WHERE s2.name != s1.name);


-- Which student was born closest to the cohort's graduation date?
select s.name, DATE_FORMAT(s.dob,'2019-%m-%d'),
 abs(datediff(DATE_FORMAT(s.dob,'2019-%m-%d'), '2019-03-06')) from students.students s
 order by  abs(datediff(DATE_FORMAT(s.dob,'2019-%m-%d'), '2019-03-06')) asc;

SELECT @d:=abs(datediff(DATE_FORMAT(s.dob,'2019-%m-%d'), '2019-03-06')) from students.students s;

select @d
from (SELECT @d:=abs(datediff(DATE_FORMAT(s.dob,'2019-%m-%d'), '2019-03-06')) from students.students s
     ) t;

-- WORKS!
select s.name,  least(abs(datediff(DATE_FORMAT(s.dob,'2019-%m-%d'), '2019-03-06')),
                      abs(datediff(DATE_FORMAT(s.dob,'2018-%m-%d'), '2019-03-06'))) as days
from students.students s
where s.dob is not null
group by s.name
order by days asc;

select s1.name, s2.days from students.students s1
	left join (select name, least(abs(datediff(DATE_FORMAT(dob,'2019-%m-%d'), '2019-03-06')),
                                  abs(datediff(DATE_FORMAT(dob,'2018-%m-%d'), '2019-03-06'))) as days
				from students.students 
				where dob is not null) s2 on (s1.name = s2.name)
	where days is not null 
    group by s1.name
	order by s2.days asc;

-- WORKS TOO !!
select s1.name, least(abs(datediff(DATE_FORMAT(dob,'2019-%m-%d'), '2019-03-06')),
					  abs(datediff(DATE_FORMAT(dob,'2018-%m-%d'), '2019-03-06'))) as days
				  from students.students s1
	left join (select name, min(least(abs(datediff(DATE_FORMAT(dob,'2019-%m-%d'), '2019-03-06')),
                                  abs(datediff(DATE_FORMAT(dob,'2018-%m-%d'), '2019-03-06')))) as  minDays
				from students.students 
				where dob is not null) s2 on true 
    where least(abs(datediff(DATE_FORMAT(dob,'2019-%m-%d'), '2019-03-06')),
					  abs(datediff(DATE_FORMAT(dob,'2018-%m-%d'), '2019-03-06'))) = minDays;
                      
-- WORKS 3
select s1.name, s1.dob, minDays, least(abs(datediff(DATE_FORMAT(dob,'2019-%m-%d'), '2019-03-06')),
					  abs(datediff(DATE_FORMAT(dob,'2018-%m-%d'), '2019-03-06'))) as days
				  from students.students s1
	left join (select name, min(least(abs(datediff(DATE_FORMAT(dob,'2019-%m-%d'), '2019-03-06')),
                                  abs(datediff(DATE_FORMAT(dob,'2018-%m-%d'), '2019-03-06')))) as  minDays
				from students.students 
				where dob is not null) s2 on true 
    group by s1.name, s1.dob, minDays
    having least(abs(datediff(DATE_FORMAT(dob,'2019-%m-%d'), '2019-03-06')),
					  abs(datediff(DATE_FORMAT(dob,'2018-%m-%d'), '2019-03-06'))) = minDays;
-- WORKS 4 !!
select s1.name, s1.dob, minDays, least(abs(datediff(DATE_FORMAT(dob,'2019-%m-%d'), '2019-03-06')),
					  abs(datediff(DATE_FORMAT(dob,'2018-%m-%d'), '2019-03-06'))) as days
				  from students.students s1
	left join (select name, min(least(abs(datediff(DATE_FORMAT(dob,'2019-%m-%d'), '2019-03-06')),
                                  abs(datediff(DATE_FORMAT(dob,'2018-%m-%d'), '2019-03-06')))) as  minDays
				from students.students 
				where dob is not null) s2 on true 
    group by s1.name, s1.dob, minDays
    having days = minDays;
    
 SELECT 
	name
    ,dob
    ,LEAST(ABS(DAYOFYEAR(dob) - 66) 
        ,ABS((DAYOFYEAR(dob) + 365) - 66) 
        ,ABS(DAYOFYEAR(dob) - (66 + 365)))
FROM students.students s1
ORDER BY 3
