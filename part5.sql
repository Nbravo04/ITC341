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

