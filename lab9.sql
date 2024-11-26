
-- Task 1: Stored procedure to increase value by 10
CREATE OR REPLACE FUNCTION increase_value(val INTEGER)
RETURNS INTEGER AS $$
BEGIN
 RETURN val + 10;
END;
$$ LANGUAGE plpgsql;
-- Task 2: Compare two numbers
CREATE OR REPLACE FUNCTION compare_numbers(val1 INTEGER, val2 INTEGER)
RETURNS TEXT AS $$
BEGIN
 IF val1 > val2 THEN
 RETURN 'Greater';
 ELSIF val1 = val2 THEN
 RETURN 'Equal';
 ELSE
 RETURN 'Less';
 END IF;
END;
$$ LANGUAGE plpgsql;
-- Task 3: Generate a number series
CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS TABLE(series INTEGER) AS $$
BEGIN
 FOR series IN 1..n LOOP
 RETURN NEXT series;
 END LOOP;
END;
$$ LANGUAGE plpgsql;
-- Task 4: Find employee details by name
CREATE OR REPLACE FUNCTION find_employee(emp_name VARCHAR)
RETURNS TABLE(id INTEGER, name VARCHAR, position VARCHAR, salary NUMERIC) AS $$
BEGIN
 RETURN QUERY SELECT id, name, position, salary
 FROM employees
 WHERE name = emp_name;
END;
$$ LANGUAGE plpgsql;
-- Task 5: List products by category
CREATE OR REPLACE FUNCTION list_products(category_name VARCHAR)
RETURNS TABLE(product_id INTEGER, product_name VARCHAR, price NUMERIC) AS $$
BEGIN
 RETURN QUERY SELECT product_id, product_name, price
 FROM products
 WHERE category = category_name;
END;
$$ LANGUAGE plpgsql;
-- Task 6: Procedures with nested calls
CREATE OR REPLACE FUNCTION calculate_bonus(emp_id INTEGER)
RETURNS NUMERIC AS $$
DECLARE
 bonus NUMERIC;
BEGIN
 SELECT salary * 0.1 INTO bonus
 FROM employees
 WHERE id = emp_id;
 RETURN bonus;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION update_salary(emp_id INTEGER)
RETURNS VOID AS $$
DECLARE
 bonus NUMERIC;
BEGIN
 bonus := calculate_bonus(emp_id);
 UPDATE employees
 SET salary = salary + bonus
 WHERE id = emp_id;
END;
$$ LANGUAGE plpgsql;
-- Task 7: Complex calculation
CREATE OR REPLACE FUNCTION complex_calculation(num1 INTEGER, str VARCHAR)
RETURNS TEXT AS $$
DECLARE
 numeric_result INTEGER;
 string_result VARCHAR;
BEGIN
 -- Subblock 1: Numeric computation
 numeric_result := num1 * 10;
 -- Subblock 2: String manipulation
 string_result := 'Processed: ' || str;
 -- Combine results
 RETURN 'Number: ' || numeric_result || ', Text: ' || string_result;
END;
$$ LANGUAGE plpgsql;