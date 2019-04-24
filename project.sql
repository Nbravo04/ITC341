-- Nicholas Bravata
-- Tabbatha Seifert
-- Joshua Machuta
-- April 22, 2019
-- Final Project, Triggers.sql 
-- ITC 341

set linesize 130;
set echo on;
set serveroutput on;
set timing on;

-- Part 3
-- Triggers for Department Table 
create or replace trigger dept_trigger
after insert on department
begin
	update department SET dname = upper(dname);
end;
/
show errors

-- **** Test **** --
-- before update
select * from department; 

-- update - lowercase dname
insert into Department values ('Lab', 9, '333445555', null);

-- notice that dnames are all uppercase now
select * from department; 

-- undo the update (insert)
rollback; 

-- notice that dnames are all lowercase now
select * from department;

-------------------------------------------------------------
-- Triggers for Dept_Locations TABLE
create or replace trigger dept_locations_trigger
after insert on Dept_Locations
begin
	update Dept_Locations SET dlocation = upper(dlocation);
end;
/
show errors

-- **** Test **** --
-- before update
select * from Dept_Locations; 

-- update - lowercase dname
insert into Dept_Locations values (5, 'Detroit');

-- notice that dnames are all uppercase now
select * from Dept_Locations; 

-- undo the update (insert)
rollback; 

-- notice that dnames are all lowercase now
select * from Dept_Locations;

-------------------------------------------------------------
-- Triggers for Employee TABLE
create or replace trigger employee_trigger
after insert on Employee
begin
	update Employee SET fname = upper(fname);
	update Employee SET minit = upper(minit);
	update Employee SET lname = upper(lname);
	update Employee SET address = upper(address);
end;
/
show errors

-- **** Test **** --
-- before update
select * from Employee; 

-- update - lowercase chars in employee
insert into Employee values ('Nicholas','J','Bravata','231123111','06-MAR-95','2726 Black Eagle Valley Dr., Howell, MI','M',80000,null,4);

-- notice that chars are all uppercase now
select * from Employee; 

-- undo the update (insert)
rollback; 

-- notice that dnames are all lowercase now
select * from Employee;

-------------------------------------------------------------
-- Triggers for Project TABLE
create or replace trigger project_trigger
after insert on Project
begin
	update Project SET pname = upper(pname);
	update Project SET plocation = upper(plocation);
end;
/
show errors

-- **** Test **** --
-- before update
select * from Project; 

-- update - lowercase chars in Project
insert into Project values('Autonomy', 101, 'Detroit', 5);

-- notice that chars are all uppercase now
select * from Project; 

-- undo the update (insert)
rollback; 

-- notice that chars are all lowercase now
select * from Project;


-------------------------------------------------------------
-- Triggers for Dependent TABLE
create or replace trigger Dependent_trigger
after insert on Dependent
begin
	update Dependent SET dependent_name = upper(dependent_name);
	update Dependent SET relationship = upper(relationship);
end;
/
show errors

-- **** Test **** --
-- before update
select * from Dependent; 

-- update - lowercase chars in Dependent
insert into Dependent values('123456789', 'Maxwell', 'M', '25-OCT-01', 'Son');

-- notice that chars are all uppercase now
select * from Dependent; 

-- undo the update (insert)
rollback; 

-- notice that chars are all lowercase now
select * from Dependent;

-- part 4
-- Function that returns Dname from Department for any given employee. 
-- The parameter to the function is the SSN.

CREATE OR REPLACE FUNCTION get_dept_name(EMPSSN IN employee.ssn%type)
   RETURN department.dname%type
IS 
   mm department.dname%type;
BEGIN
   mm := '';  -- initially empty value 

   SELECT dname into mm FROM EMPLOYEE E, DEPARTMENT D 
   WHERE E.DNO = D.DNUMBER AND E.SSN = EMPSSN ;

   RETURN(mm);

-- exception handling

   exception
     when NO_DATA_FOUND then
       dbms_output.put_line('No data found');
       RETURN(mm);

END;
/
show errors

-- **** Test **** -- function call
declare 
	deptname department.dname%type;
begin
-- function call
	deptname := get_dept_name('123456789'); 
	dbms_output.put_line('dept name for ' || '123456789' || ' is ' || deptname);

-- function call   
	deptname := get_dept_name('111111111');
	if deptname != '' then
		dbms_output.put_line('dept name for ' || '111111111' || ' is ' || deptname);
	end if;
end;
/

-- using the function in a query
select lname || ', ' || fname || ' ' || 'works at ' || get_dept_name(ssn) || '.' as EMP_DEPT_INFO
from employee;

-- part 5
-- Implement a Function that returns manager’s full name for any given department. 
-- The parameter to the function would be the department name.

CREATE OR REPLACE FUNCTION get_manager_name(DEPTNAME IN department.dname%type)
   RETURN varchar2
IS 
	fn employee.fname%type;
	lnm employee.lname%type;
	fulln varchar2(50);
BEGIN
	fn := '';  -- initially empty value 
	lnm := '';  -- initially empty value 
	fulln := ''; -- initially empty value 
	
	SELECT E.fname, E.lname into fn, lnm FROM DEPARTMENT D, EMPLOYEE E 
	WHERE D.mgrssn = E.SSN and D.dname = DEPTNAME;

	fulln := fn || ' ' || lnm;
	
	RETURN(fulln);

-- exception handling

   exception
     when NO_DATA_FOUND then
       dbms_output.put_line('No data found');
       RETURN(fulln);

END;
/
show errors

-- Part 6
-- Implement another Function such that for any given project, it should return full name of the manager of the
-- department that controls the project. The parameter to the function would be the project name.

CREATE OR REPLACE FUNCTION get_manager_name2(PROJECTNAME IN project.pname%type)
   RETURN varchar2
IS 
	fn employee.fname%type;
	lnm employee.lname%type;
	fulln varchar2(50);
BEGIN
	fn := '';  -- initially empty value 
	lnm := '';  -- initially empty value 
	fulln := ''; -- initially empty value 
	
	SELECT E.fname, E.lname into fn, lnm FROM DEPARTMENT D, EMPLOYEE E, PROJECT P
	WHERE P.dnum = D.dnumber and D.mgrssn = E.SSN and P.pname = PROJECTNAME;

	fulln := fn || ' ' || lnm;
	
	RETURN(fulln);

-- exception handling

   exception
     when NO_DATA_FOUND then
       dbms_output.put_line('No data found');
       RETURN(fulln);

END;
/
show errors

-- **** Test **** -- function call

declare 
	mgrname varchar2(50);
begin
-- function call
	mgrname := get_manager_name2('ProductX'); 
	dbms_output.put_line('mgr. name name for ' || 'ProductX' || ' is ' || mgrname);

-- function call   
	mgrname := get_manager_name2('Printing');
	if mgrname != '' then
		dbms_output.put_line('mgr. name for ' || 'Printing' || ' is ' || mgrname);
	end if;
end;
/

-- using the function in a query

select pname || ' has manager ' || get_manager_name2(pname) || '.' as DEPT_MGR_INFO
from project;

-- Part 7
--Implement a Procedure that increases an employee salary by x%. Employee is identified by SSN and the percentage
--of increase is given as an input.
CREATE OR REPLACE PROCEDURE increase_emp_salary(EMPSSN IN employee.ssn%type, INCREASE IN number)
AS 
   es employee.salary%type;
BEGIN 
   es := '';  -- initially empty value 
 
   SELECT salary*(1 + INCREASE/100) into es FROM EMPLOYEE
   WHERE SSN = EMPSSN ;
   
   UPDATE employee SET salary = es WHERE ssn = 'EMPSSN';
   
   dbms_output.put_line('New salary is '|| es);

-- exception handling

   exception
     when NO_DATA_FOUND then
       dbms_output.put_line('No data found');

END;
/
show errors

-- **** Test **** -- sp call
-- calling the stored procedure get_dept_name_sp
exec increase_emp_salary('123456789', 5);
exec increase_emp_salary('333445555', 10);

rollback;

-- Part 8
-- Implement a Package that contains the following methods:
-- Count the number of dependents for any given valid employee (test first if the employee is a valid one).
-- Add a dependent for any given valid employee (test first if the employee is a valid one).
-- Remove a dependent for any given valid employee (test first if the employee is a valid one).

-- **** Package Declaration **** --
create or replace package dep_package as
		procedure num_dependents(EMPSSN in employee.ssn%type);
		procedure add_dependent(empssn in dependent.essn%type, dep_name in dependent.dependent_name%type, 
				sex in dependent.sex%type, brthdate in dependent.bdate%type, 
				rship in dependent.relationship%type);
		procedure del_dependent(essn in dependent.essn%type, dname in dependent.dependent_name%type);
		
end;
/
show errors

create or replace package body dep_package as
	procedure num_dependents(EMPSSN in employee.ssn%type)
    as
		dc number;
    begin
		select count(*) into dc from employee E, dependent D
		where EMPSSN = E.ssn and E.ssn = D.essn;
    
		dbms_output.put_line('Count of dependents for emp. ' || EMPSSN || ' is ' || dc);

		-- exception handling
		exception
		when NO_DATA_FOUND then
			dbms_output.put_line('No data found');
    end;
	
	procedure add_dependent(empssn in dependent.essn%type, dep_name in dependent.dependent_name%type, 
			sex in dependent.sex%type, brthdate in dependent.bdate%type, rship in 
			dependent.relationship%type)

	as
	begin 
		insert into dependent values(empssn, dep_name, sex, brthdate, rship);
		
		dbms_output.put_line('Dependent was added.');	
		
		-- exception handling
		exception
     		when NO_DATA_FOUND then
        		dbms_output.put_line('Employee not found');
     
	end;

	procedure del_dependent(essn in dependent.essn%type, dname in dependent.dependent_name%type)
	
	as
	begin 
		delete from dependent d
		where d.essn = essn and d.dependent_name = dname;
		
		dbms_output.put_line('Dependent was deleted');
	
		-- exception handling
		exception
		when NO_DATA_FOUND then
		dbms_output.put_line('Employee not found');
	end;  
end;
/
show errors
	   
-- **** Test **** --
exec dep_package.num_dependents('333445555');
exec dep_package.add_dependent('987654321','Joe', 'M', '04-APR-54', 'Father');
select* from dependent;
exec dep_package.del_dependent('987654321', 'Joe');
select* from dependent;

rollback;
