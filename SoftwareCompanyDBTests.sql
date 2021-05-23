-- Script name 	SoftwareCompanyDBTests.sql
-- Author:		Robert Freeman
-- Purpose: 	Testing the integrity of SoftwareCompanyDB

-- Database used to insert the data
USE `SoftwareCompanyDB`;
SET SQL_SAFE_UPDATES=0;

-- 1.Testing Person table
-- UPDATE Person SET person_id = 7 WHERE name = 'Billy';
-- 1. Error in Person UPDATE
	-- Query: UPDATE Person SET person_id = 7 WHERE name = 'Billy';
    -- Query: DELETE FROM Person WHERE name = 'Robert Freeman';
    -- Error: user_id referenced value cannot be found in the parent table

-- 2. Testing Account table
UPDATE Account SET account_id = 4 WHERE email ='Rob@example.com';
DELETE FROM Account WHERE email = 'bob@thisexample.com';
-- No errors

-- 3. Testing Registered_User table
	UPDATE Registered_User SET user_id = 4 WHERE username = 'sgsa';
	-- Query: DELETE FROM Registered_User WHERE password = 'dafa';
    -- Error: Cannot update or delete a value in parent table
    
-- 4. Testing Address table
UPDATE Address SET address_id = 4 WHERE Billing = 'BS';
	-- Query: DELETE FROM Address WHERE shipping = 'sg';
    -- Error: Cannot update or delete values in parent table
    
-- 5. Testing User_Address table
UPDATE User_Address SET registered_user = 4 WHERE address = 1;
	-- Query: DELETE FROM User_Address WHERE address = 2;
    -- Error: Cannot update a child row
    
-- 6. Testing Client table
UPDATE Client SET purchase = 'p' WHERE client_id = 1;
	-- Query: DELETE FROM Client WHERE complaint = 2;
	-- Error: Cannot update a parent row
        
-- 7. Testing Complaint table
UPDATE Complaint SET resolved = 0 WHERE complaint_id = 1;
DELETE FROM Complaint WHERE client = 1;
-- No errors!

-- 8. Testing Employee table
UPDATE Employee SET uniform = "blue" WHERE employee_id = 1;
	-- Query: DELETE FROM Employee WHERE employee_id = 2;
    -- Error: Cannot delete or update a parent row

-- 9. Testing Office table
UPDATE Office SET rent = 40 WHERE office_id = 1;
DELETE FROM Office WHERE utilities = 7.7;
-- No errors!

-- 10. Testing Computer table
UPDATE Computer SET personal = 0 WHERE computer_id = 1;
DELETE FROM Computer WHERE computer_id = 1;
-- No errors!

-- 11. Testing Desk table
UPDATE Desk SET office = 3 WHERE desk_id = 1;
DELETE FROM Desk WHERE desk_id = 1;

-- 12. Testing Benefits table
UPDATE Benefits SET dental = 4 WHERE benefit_id = 1;
DELETE FROM Benefits WHERE benefit_id = 1;

-- 13. Testing Bonus table
UPDATE Bonus SET signing = 7 WHERE bonus_id = 1;
DELETE FROM Bonus WHERE bonus_id = 1;

-- 14. Testing Pay table
UPDATE Pay SET salary = 5 WHERE pay_id = 1;
DELETE FROM Pay WHERE pay_id = 1;

-- 15. Testing Tax table
 UPDATE Tax SET sales = 0.82 WHERE tax_id = 1;
	-- Query: DELETE FROM Tax WHERE tax_id = 1;
	-- Error: Cannot delete or update a parent row
    
-- 16. Testing Supplies table
UPDATE Supplies SET office = 'main' WHERE supplies_id = 1;
DELETE FROM Supplies WHERE supplies_id = 1;

-- 17. Testing Supplies_Tax table
UPDATE Supplies_Tax SET supplies = 1 WHERE supplies_tax_id = 1;
DELETE FROM Supplies_Tax WHERE supplies_tax_id = 1;

-- 18. Testing Product table
	UPDATE Product SET current_version = '1.1.0' WHERE product_id = 1;
	-- Query: DELETE FROM Product WHERE product_id = 1;
    -- Error: Parent row cannot be updated or deleted
    
-- 19. Testing Ad table
UPDATE Ad SET title = 'title' WHERE ad_id = 1;
	-- Query: DELETE FROM Ad WHERE ad_id = 1;
    -- Error: Parent row cannot be updated or deleted
    
-- 20. Testing Website table
	UPDATE Website SET product_page = 'product' WHERE web_id = 1;
	-- Query: DELETE FROM Website WHERE web_id = 1;
    -- Error: Cannot delete or update a parent row
    
-- 21. Testing Host table
UPDATE Host SET ad = 1 WHERE hosts_id = 1;
DELETE FROM Host WHERE hosts_id = 1;

-- 22. Testing Product_Advsertisement table
UPDATE Product_Advertisement SET product = 1 WHERE product_advertisement_id = 1;
DELETE FROM Product_Advertisement WHERE product_advertisement_id = 1;

-- 23. Testing Product_Tax table
	-- Query: UPDATE Product_Tax SET product = 4 WHERE product_tax_id = 2;
DELETE FROM Product_Tax WHERE product_tax_id = 4;
    -- Error: Child row cannot be deleted or updated
    
-- 24. Sale table
UPDATE Sale SET description = 'desc' WHERE sale_id = 1;
	-- Query: DELETE FROM Sale WHERE sale_id = 1;
    -- Error: Parent row cannot be deleted or updated
    
-- 25. Testing Product_Sale table
UPDATE Product_Sale SET product = 1 WHERE product_sale_id = 1;
DELETE FROM Product_Sale WHERE product_sale_id = 1;

-- 26. Testing IT_Service_Order table
UPDATE IT_Service_Order SET notes = 'note' WHERE service_id = 1;
-- Query: DELETE FROM IT_Service_Order WHERE service_id = 1;
-- Error: Cannot delete or update a parent row

-- 27. Testing IT_Sales table
UPDATE IT_Sales SET service_order = 1 WHERE it_sale_id = 1;
DELETE FROM IT_Sales WHERE it_sale_id = 1;

-- 28. Testing Software_As_a_Service table
UPDATE Software_As_a_Service SET reissue_date = '1' WHERE software_as_a_service_id = 1;
-- Query: DELETE FROM Software_As_a_Service WHERE software_as_a_service_id = 1;
-- Error: Cannot delete or update a parent row

-- 29. Testing Subscription_Sale
UPDATE Subscription_Sale SET software_as_a_service = 1 WHERE subscription_sales_id = 1;
DELETE FROM Subscription_Sale WHERE subscription_sales_id = 1;

-- 30. Testing Department table
UPDATE Department SET accounts_and_finance = 1 WHERE department_id = 1;
DELETE FROM Department WHERE department_id = 1;

-- 31. Testing Department_Sale table
UPDATE Department_Sale SET department = 1 WHERE department_sale_id = 1;
DELETE FROM Department_Sale WHERE department_sale_id = 1;