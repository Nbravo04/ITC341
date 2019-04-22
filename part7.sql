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
