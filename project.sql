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

