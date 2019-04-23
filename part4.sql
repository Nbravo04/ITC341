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
