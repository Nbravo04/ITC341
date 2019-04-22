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
