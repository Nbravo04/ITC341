set linesize 120;
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


