-- Part 8
-- Implement a Package that contains the following methods:
-- Count the number of dependents for any given valid employee (test first if the employee is a valid one).
-- Add a dependent for any given valid employee (test first if the employee is a valid one).
-- Remove a dependent for any given valid employee (test first if the employee is a valid one).

-- **** Package Declaration **** --
create or replace package dep_package as

		procedure add_dependent(empssn in dependent.empssn%type, dep_name in dependent.dep_name%type, sex in dependent.sex%type, brthdate in dependent.brthdate%type, rship in dependent.rship%type);
		procedure del_dependent(dessn in dependent.empssn%type);
		
end;
/
show errors
 create or replace package body dep_package as
	procedure add_dependent(empssn in dependent.empssn%type, dep_name in dependent.dep_name%type, sex in dependent.sex%type, brthdate in dependent.brthdate%type, rship in dependent.rship%type)

	as
	begin 
	insert into dependent values(empssn, dep_name, sex, brthdate, rship);
	dbms_output.put_line('Dependent was added.');	

	exception
     when NO_DATA_FOUND then
       dbms_output.put_line('Not found');
     
END;

	procedure del_dependent(dessn in dependent.empssn%type)
	
	as
	begin 
	delete from dependent d
	where d.empssn = dessn;
	dbms_output.put_line('dependent was deleted');
	
		exception
		when NO_DATA_FOUND then
		dbms_output.put_line('Not found');
	  end; 
	   
	   end;
	   /
	   show errors
	   
	  exec dep_package.add_dependent('987654321','Dad', 'M', to_date('','YYYY-MM-DD'), 'Father');
	  select* from dependent;
	  exec dep_package.del_dependent('987654321');
	  select* from dependent;
	   
	   declare 
	mgrname varchar2(50);
	mgrname2 varchar2(50);
	
	
	begin
--Call Function
	mgrname := get_manager_name('Research'); 
	dbms_output.put_line('mgr. name name for ' || 'Research' || ' is ' || mgrname);
	
		mgrname := get_manager_name('Printing');
	if mgrname != '' then
		dbms_output.put_line('mgr. name for ' || 'Printing' || ' is ' || mgrname);
	end if;
end;
	   
		begin
--Call Function
	mgrname2 := get_manager_name('6'); 
	dbms_output.put_line('mgr. name name for dept number' || '6' || ' is ' || mgrname);
	
		mgrname2 := get_manager_name('Printing');
	if mgrname2 != '' then
		dbms_output.put_line('mgr. name for ' || 'Printing' || ' is ' || mgrname);
	end if;
end;

	
