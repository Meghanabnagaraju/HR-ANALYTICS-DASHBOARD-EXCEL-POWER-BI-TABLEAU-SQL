create database project_171;
-- TABLE(HR 1)
CREATE TABLE HR_1(
AGE INT,
ATTRITION CHAR(10),
BUSINESSTRAVEL VARCHAR(250),
DAILYRATE INT,
DEPARTMENT VARCHAR(255),
DISTANCEFROMHOME INT,
EDUCATION INT,
EDUCATIONFIELD VARCHAR(250),
EMPLOYEECOUNT INT,
EMPLOYEENUMBER INT,
ENVIRONMENTSATISFACTION INT,
GENDER CHAR(10),
HOURLYRATE INT,
JOBINVOLVEMENT INT,
JOBLEVEL INT,
JOBROLE VARCHAR(255),
JOBSATISFACTION INT,
MARITALSTATUS VARCHAR(100)
);
LOAD data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\HR_1.csv'
into table HR_1
fields terminated by ','
lines terminated by '\n'
ignore 1 lines;
-- TABLE(HR 2)
CREATE TABLE HR_2(
EMPLOYEE_ID INT,
MONTHLYINCOME INT,
MONTHLYRATE INT,
NUMCOMPANIESWORKED INT,
OVER18 CHAR(10),
OVERTIME VARCHAR(50),
PERCENTSALARYHIKE INT,
PERFORMANCERATING INT,
RELATIONSHIPSATISFACTION INT,
STANDARDHOURS INT,
STOCKOPTIONLEVEL INT,
TOTALWORKINGYEARS INT,
TRAININGTIMESLASTYEAR INT,
WORKLIFEBALANCE INT,
YEARSATCOMPANY INT,
YEARSINCURRENTROLE INT,
YEARSSINCELASTPROMOTION INT,
YEARSWITHCURRMANAGER INT
);
LOAD data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\HR_2.csv'
into table HR_2
fields terminated by ','
lines terminated by '\n'
ignore 1 rows;

select count(*) from hr_2;

-- KPI1 Average Attrition rate for all Departments
select  department,
  count( case 
       when Attrition ="Yes" then 1
       end )/ count(attrition) * 100 as attrition_rate 
 from hr_1  group by department order by department desc ;
 
 -- KPI2 Average Hourly rate of Male Research Scientist
 select avg(HourlyRate) from hr_1 where gender = "Male" and jobrole = "Research Scientist";
 
 -- KPI3 Attrition rate Vs Monthly income stats
 select  
     case 
        when monthlyincome between 1001 and 10001 then "1001 -10001"
        when monthlyincome between 10002 and 19002 then "10002 - 19002"
        when monthlyincome between 19003 and 28003 then "19003 - 28003"
        when monthlyincome between 28004 and 37004 then "28004 - 37004"
        when monthlyincome between 37005 and 46005 then "37005 - 46005"
        when monthlyincome between 46006 and 55006 then "46006 -55006"
        end as monthlyincome_group,
count( case 
       when Attrition ="Yes" then 1
       end )/ count(attrition) * 100 as attrition_rate
from hr_1 inner join hr_2 on hr_1.employeenumber = hr_2.`ï»¿Employee ID` group by monthlyincome_group ;

-- KPI4 Average working years for each Department
select hr_1.department ,
avg(hr_2.totalworkingyears) as avg_working_years from hr_1 
inner join 
hr_2 on hr_1.employeenumber = hr_2. `ï»¿Employee ID` 
group by hr_1.department 
order by hr_1.department desc;

-- KPI5 Job Role Vs Work life balance
select JobRole,WorkLifeBalance,
count(JobRole) as JB_vs_WFB 
from hr_1 inner join hr_2 on hr_1.employeenumber = hr_2.`ï»¿Employee ID`
group by JobRole,  WorkLifeBalance 
order by WorkLifeBalance;

-- KPI6 Attrition rate Vs Year since last promotion relation
select YearsSinceLastPromotion , 
count( case 
       when Attrition ="Yes" then 1
       end )/ count(attrition) * 100 as attrition_rate
from hr_1 inner join hr_2 on hr_1.employeenumber = hr_2.`ï»¿Employee ID` 
group by  YearsSinceLastPromotion
order by  YearsSinceLastPromotion ;
