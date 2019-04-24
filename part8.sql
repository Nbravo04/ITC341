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
