

-- Bank DDL--

DROP DATABASE IF EXISTS BankDB;

-- Create Database
CREATE DATABASE BankDB;
USE BankDB;

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255),
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Create AccountTypes Table
CREATE TABLE AccountTypes (
    AccountTypeID INT AUTO_INCREMENT PRIMARY KEY,
    AccountTypeName VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Create Accounts Table
CREATE TABLE Accounts (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountTypeID INT NOT NULL,
    Balance DECIMAL(18, 2) DEFAULT 0,
    OpenDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (AccountTypeID) REFERENCES AccountTypes(AccountTypeID) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Create Transactions Table
CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT NOT NULL,
    TransactionType VARCHAR(50) NOT NULL, -- e.g., Deposit, Withdrawal
    Amount DECIMAL(18, 2) NOT NULL,
    TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Create Loans Table
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    LoanType VARCHAR(50) NOT NULL,
    PrincipalAmount DECIMAL(18, 2) NOT NULL,
    InterestRate DECIMAL(5, 2) NOT NULL,
    StartDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Create LoanPayments Table
CREATE TABLE LoanPayments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    LoanID INT NOT NULL,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    AmountPaid DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Create Branches Table
CREATE TABLE Branches (
    BranchID INT AUTO_INCREMENT PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    BranchID INT NOT NULL,
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Create Cards Table
CREATE TABLE Cards (
    CardID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT NOT NULL,
    CardType VARCHAR(50) NOT NULL, -- e.g., Debit, Credit
    IssueDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    ExpiryDate DATETIME NOT NULL,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Create AuditLog Table
CREATE TABLE AuditLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Action VARCHAR(255) NOT NULL,
    ActionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    UserID INT
) ENGINE=InnoDB;


-- Bank DML --

USE BankDB;

-- Insert Account Types
INSERT INTO AccountTypes (AccountTypeName)
VALUES 
('Savings'), 
('Checking'), 
('Business'), 
('Fixed Deposit'), 
('Recurring Deposit');

-- Insert Branches
INSERT INTO Branches (BranchName, Address)
VALUES 
('Downtown Branch', '123 Main Street, Cityville'),
('Uptown Branch', '456 Elm Street, Cityville'),
('Eastside Branch', '789 Oak Avenue, Cityville'),
('Westside Branch', '321 Cedar Lane, Cityville'),
('Northside Branch', '654 Birch Road, Cityville');

-- Insert Customers
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, Address)
VALUES 
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '789 Maple St, Cityville'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Pine St, Cityville'),
('Alice', 'Brown', 'alice.brown@example.com', '555-666-7777', '123 Spruce St, Cityville'),
('Bob', 'Johnson', 'bob.johnson@example.com', '222-333-4444', '321 Willow St, Cityville'),
('Charlie', 'Davis', 'charlie.davis@example.com', '999-888-7777', '987 Aspen St, Cityville'),
('Diana', 'Clark', 'diana.clark@example.com', '111-222-3333', '654 Cherry St, Cityville'),
('Ethan', 'White', 'ethan.white@example.com', '444-555-6666', '345 Redwood St, Cityville'),
('Fiona', 'Harris', 'fiona.harris@example.com', '888-999-1111', '876 Poplar St, Cityville'),
('George', 'Miller', 'george.miller@example.com', '777-888-9999', '543 Elm St, Cityville'),
('Hannah', 'Moore', 'hannah.moore@example.com', '666-777-8888', '210 Pinecone St, Cityville');

-- Insert Accounts
INSERT INTO Accounts (CustomerID, AccountTypeID, Balance)
VALUES 
(1, 1, 2000.00), 
(2, 2, 1500.00), 
(3, 3, 10000.00), 
(4, 4, 5000.00), 
(5, 5, 7000.00), 
(6, 1, 2500.00), 
(7, 2, 3000.00), 
(8, 3, 12000.00), 
(9, 4, 8000.00), 
(10, 5, 4000.00);

-- Insert Transactions
INSERT INTO Transactions (AccountID, TransactionType, Amount)
VALUES 
(1, 'Deposit', 500.00), 
(2, 'Withdrawal', 200.00), 
(3, 'Transfer', 1500.00), 
(4, 'Deposit', 300.00), 
(5, 'Withdrawal', 500.00), 
(6, 'Deposit', 700.00), 
(7, 'Transfer', 1000.00), 
(8, 'Withdrawal', 200.00), 
(9, 'Deposit', 900.00), 
(10, 'Transfer', 400.00);

-- Insert Loans
INSERT INTO Loans (CustomerID, LoanType, PrincipalAmount, InterestRate)
VALUES 
(1, 'Home Loan', 50000.00, 3.5), 
(2, 'Auto Loan', 20000.00, 5.0), 
(3, 'Education Loan', 30000.00, 4.0), 
(4, 'Personal Loan', 10000.00, 6.5), 
(5, 'Business Loan', 70000.00, 7.0), 
(6, 'Home Loan', 45000.00, 3.8), 
(7, 'Auto Loan', 25000.00, 4.5), 
(8, 'Education Loan', 35000.00, 4.2), 
(9, 'Personal Loan', 15000.00, 6.0), 
(10, 'Business Loan', 80000.00, 7.5);

-- Insert Loan Payments
INSERT INTO LoanPayments (LoanID, PaymentDate, AmountPaid)
VALUES 
(1, NOW(), 5000.00), 
(2, NOW(), 2000.00), 
(3, NOW(), 3000.00), 
(4, NOW(), 1000.00), 
(5, NOW(), 7000.00), 
(6, NOW(), 4500.00), 
(7, NOW(), 2500.00), 
(8, NOW(), 3500.00), 
(9, NOW(), 1500.00), 
(10, NOW(), 8000.00);

-- Insert Employees
INSERT INTO Employees (FirstName, LastName, Role, BranchID)
VALUES 
('Emily', 'Adams', 'Manager', 1), 
('Frank', 'Bell', 'Teller', 2), 
('Grace', 'Carter', 'Clerk', 3), 
('Harry', 'Dixon', 'Manager', 4), 
('Ivy', 'Evans', 'Teller', 5), 
('Jack', 'Foster', 'Clerk', 1), 
('Kate', 'Green', 'Manager', 2), 
('Leo', 'Hughes', 'Teller', 3), 
('Mia', 'Ingram', 'Clerk', 4), 
('Nina', 'Johnson', 'Manager', 5);

-- Insert Cards
INSERT INTO Cards (AccountID, CardType, IssueDate, ExpiryDate)
VALUES 
(1, 'Debit', NOW(), DATE_ADD(NOW(), INTERVAL 3 YEAR)), 
(2, 'Credit', NOW(), DATE_ADD(NOW(), INTERVAL 3 YEAR)), 
(3, 'Debit', NOW(), DATE_ADD(NOW(), INTERVAL 3 YEAR)), 
(4, 'Credit', NOW(), DATE_ADD(NOW(), INTERVAL 3 YEAR)), 
(5, 'Debit', NOW(), DATE_ADD(NOW(), INTERVAL 3 YEAR)), 
(6, 'Credit', NOW(), DATE_ADD(NOW(), INTERVAL 3 YEAR)), 
(7, 'Debit', NOW(), DATE_ADD(NOW(), INTERVAL 3 YEAR)), 
(8, 'Credit', NOW(), DATE_ADD(NOW(), INTERVAL 3 YEAR)), 
(9, 'Debit', NOW(), DATE_ADD(NOW(), INTERVAL 3 YEAR)), 
(10, 'Credit', NOW(), DATE_ADD(NOW(), INTERVAL 3 YEAR));

-- Insert Audit Logs
INSERT INTO AuditLog (Action, ActionDate, UserID)
VALUES 
('Created Customer John Doe', NOW(), 1), 
('Updated Account Balance for Jane Smith', NOW(), 2), 
('Loan Approved for Alice Brown', NOW(), 3), 
('Transaction Logged for Bob Johnson', NOW(), 4), 
('Branch Added', NOW(), 5), 
('Employee Role Updated', NOW(), 6), 
('Audit Trail Checked', NOW(), 7), 
('Loan Payment Recorded', NOW(), 8), 
('Card Issued', NOW(), 9), 
('Customer Address Updated', NOW(), 10);
USE BankDB;

-- Display all customers
SELECT * FROM Customers;
-- Display all account types
SELECT * FROM AccountTypes;
-- Display all accounts
SELECT * FROM Accounts;
-- Display all transactions
SELECT * FROM Transactions;
-- Display all loans
SELECT * FROM Loans;
-- Display all loan payments
SELECT * FROM LoanPayments;
-- Display all branches
SELECT * FROM Branches;
-- Display all employees
SELECT * FROM Employees;
-- Display all cards
SELECT * FROM Cards;
-- Display all audit logs
SELECT * FROM AuditLog;


-- BANK STORED PROCEDURES -- 

USE BankDB;

-- ========================================
-- Procedure: Add a New Customer
-- ========================================
DELIMITER // 
CREATE PROCEDURE AddCustomer(
    IN FirstName VARCHAR(50),
    IN LastName VARCHAR(50),
    IN Email VARCHAR(100),
    IN PhoneNumber VARCHAR(15),
    IN Address VARCHAR(255)
)
BEGIN
    INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, Address)
    VALUES (FirstName, LastName, Email, PhoneNumber, Address);
END // 
DELIMITER ; 

-- Example Usage and Demo Output:
CALL AddCustomer('Billy', 'Morris', 'lucas.morris@example.com', '555-123-4567', '432 Green St, Cityville');
SELECT * FROM Customers;

-- ========================================
-- Procedure: Add a New Transaction
-- ========================================
DELIMITER // 
CREATE PROCEDURE AddTransaction(
    IN AccountID INT,
    IN TransactionType VARCHAR(50),
    IN Amount DECIMAL(18,2)
)
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    INSERT INTO Transactions (AccountID, TransactionType, Amount)
    VALUES (AccountID, TransactionType, Amount);
    
    IF TransactionType = 'Deposit' THEN
        UPDATE Accounts SET Balance = Balance + Amount WHERE AccountID = AccountID;
    ELSEIF TransactionType = 'Withdrawal' THEN
        UPDATE Accounts SET Balance = Balance - Amount WHERE AccountID = AccountID;
    END IF;

    SET SQL_SAFE_UPDATES = 1;
END //
DELIMITER ;

-- Example Usage and Demo Output:
CALL AddTransaction(1, 'Deposit', 500.00);
CALL AddTransaction(1, 'Withdrawal', 200.00);
SELECT * FROM Transactions WHERE AccountID = 1;
SELECT * FROM Accounts WHERE AccountID = 1;

-- ========================================
-- Procedure: Get Loan Details by Customer
-- ========================================
DELIMITER // 
CREATE PROCEDURE GetLoanDetailsByCustomer(IN CustID INT)
BEGIN
    SELECT Loans.LoanID, Loans.LoanType, Loans.PrincipalAmount, Loans.InterestRate, 
           SUM(LoanPayments.AmountPaid) AS TotalPaid, 
           (Loans.PrincipalAmount - COALESCE(SUM(LoanPayments.AmountPaid), 0)) AS RemainingBalance
    FROM Loans
    LEFT JOIN LoanPayments ON Loans.LoanID = LoanPayments.LoanID
    WHERE Loans.CustomerID = CustID
    GROUP BY Loans.LoanID;
END //
DELIMITER ;

-- Example Usage and Demo Output:
CALL GetLoanDetailsByCustomer(1);
SELECT * FROM Loans WHERE CustomerID = 1;

-- ========================================
-- Procedure: Assign Employee to Branch
-- ========================================
DELIMITER // 
CREATE PROCEDURE AssignEmployeeToBranch(
    IN EmpID INT,
    IN BranchID INT
)
BEGIN
    UPDATE Employees SET BranchID = BranchID WHERE EmployeeID = EmpID;
END //
DELIMITER ;

-- Example Usage and Demo Output:
CALL AssignEmployeeToBranch(1, 2);
SELECT * FROM Employees WHERE EmployeeID = 1;

-- ========================================
-- Procedure: Generate Account Statement
-- ========================================
DELIMITER // 
CREATE PROCEDURE GenerateAccountStatement(
    IN AccountID INT
)
BEGIN
    SELECT Transactions.TransactionID, Transactions.TransactionType, Transactions.Amount, 
           Transactions.TransactionDate
    FROM Transactions
    WHERE Transactions.AccountID = AccountID
    ORDER BY Transactions.TransactionDate DESC;
END //
DELIMITER ;

-- Example Usage and Demo Output:
CALL GenerateAccountStatement(1);



-- BANK VIEWS -- 
-- ========================================
-- View: Customer Account Summary
-- ========================================
CREATE VIEW CustomerAccountSummary AS
SELECT 
    Customers.CustomerID, 
    CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName,  
    Accounts.AccountID, 
    AccountTypes.AccountTypeName,   
    Accounts.Balance                 
FROM Customers
JOIN Accounts ON Customers.CustomerID = Accounts.CustomerID   
JOIN AccountTypes ON Accounts.AccountTypeID = AccountTypes.AccountTypeID;

-- Example Usage and Demo Output:
SELECT * FROM CustomerAccountSummary;



-- ========================================
-- View: Loan Payment Summary
-- ========================================
CREATE VIEW LoanPaymentSummary AS
SELECT 
    Loans.LoanID, 
    Loans.LoanType, 
    Loans.PrincipalAmount, 
    SUM(LoanPayments.AmountPaid) AS TotalPaid,   
    (Loans.PrincipalAmount - COALESCE(SUM(LoanPayments.AmountPaid), 0)) AS RemainingBalance  
FROM Loans
LEFT JOIN LoanPayments ON Loans.LoanID = LoanPayments.LoanID
GROUP BY Loans.LoanID;

-- Example Usage and Demo Output:
SELECT * FROM LoanPaymentSummary;

-- ========================================
-- View: Branch Employee List
-- ========================================
CREATE VIEW BranchEmployeeList AS
SELECT 
    Branches.BranchID, 
    Branches.BranchName, 
    Employees.EmployeeID, 
    CONCAT(Employees.FirstName, ' ', Employees.LastName) AS EmployeeName,  
    Employees.Role  
FROM Branches
JOIN Employees ON Branches.BranchID = Employees.BranchID;

-- Example Usage and Demo Output:
SELECT * FROM BranchEmployeeList;


-- TRIGGERS --


-- ========================================
-- Trigger: Update Account Balance After Transaction
-- ========================================
DELIMITER // 
CREATE TRIGGER after_transaction_insert
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    IF NEW.TransactionType = 'Deposit' THEN
        UPDATE Accounts SET Balance = Balance + NEW.Amount WHERE AccountID = NEW.AccountID;
    ELSEIF NEW.TransactionType = 'Withdrawal' THEN
        UPDATE Accounts SET Balance = Balance - NEW.Amount WHERE AccountID = NEW.AccountID;
    END IF;
END //
DELIMITER ;

-- Example Usage and Output:
INSERT INTO Transactions (AccountID, TransactionType, Amount) VALUES (1, 'Deposit', 500.00);
SELECT * FROM Accounts WHERE AccountID = 1;
INSERT INTO Transactions (AccountID, TransactionType, Amount) VALUES (1, 'Withdrawal', 200.00);
SELECT * FROM Accounts WHERE AccountID = 1;


-- INDEXES -- 

-- ========================================
-- Index Optimization
-- ========================================
CREATE INDEX idx_transactions_accountid ON Transactions (AccountID);
CREATE INDEX idx_accounts_customerid ON Accounts (CustomerID);
CREATE INDEX idx_loanpayments_loanid ON LoanPayments (LoanID);

-- Validate Indexes:
SHOW INDEX FROM Transactions;
SHOW INDEX FROM Accounts;
SHOW INDEX FROM LoanPayments;





-- ROLE BASED ACCESS CONTROL -- 
CREATE ROLE Admin;
GRANT ALL PRIVILEGES ON BankDB.* TO Admin;
create user 'Administrator' identified by 'admin1' default role 'Admin';

CREATE ROLE branchmanager;
GRANT SELECT, INSERT, UPDATE, DELETE ON BankDB.Branches TO 'branchmanager';
GRANT SELECT, INSERT, UPDATE, DELETE ON BankDB.Employees TO 'branchmanager';
GRANT SELECT, INSERT, UPDATE ON BankDB.Customers TO 'branchmanager';
GRANT SELECT, INSERT, UPDATE ON BankDB.Accounts TO 'branchmanager';

create user 'Branchmanager_user' identified by 'branchmanager1' default role 'branchmanager';


CREATE ROLE CustomerService;
GRANT SELECT, INSERT, UPDATE ON BankDB.Customers TO 'CustomerService';
GRANT SELECT, INSERT, UPDATE ON BankDB.Accounts TO 'CustomerService';

CREATE USER 'Customerservice_user' identified by 'customerservice1' default role 'CustomerService';

CREATE ROLE Teller;
GRANT SELECT, INSERT ON BankDB.Transactions TO 'Teller';
GRANT SELECT ON BankDB.Accounts TO 'Teller';

CREATE USER 'Teller_user' identified by 'teller1' default role 'Teller';

CREATE ROLE LoanOfficer;
GRANT SELECT, INSERT, UPDATE ON BankDB.Loans TO 'LoanOfficer';
GRANT SELECT, INSERT ON BankDB.LoanPayments TO 'LoanOfficer';

CREATE USER 'LoanOfficer_user' identified by 'loanofficer1' default role 'LoanOfficer';

CREATE ROLE Auditor;
GRANT SELECT ON BankDB.* TO 'Auditor';

CREATE USER 'Auditor_user' identified by 'auditor1' default role 'Auditor';


-- ADMINISTRATOR CODE --
use BankDB;
DROP TABLE IF EXISTS TestTable;
CREATE TABLE TestTable (ID INT PRIMARY KEY, Name VARCHAR(50));
INSERT INTO TestTable (ID, Name) VALUES (1, 'AdminTest');
SELECT * FROM TestTable;
DROP TABLE TestTable;

-- BRANCH MANAGER_USER CODE --
USE BankDB;
-- Insert a branch
INSERT INTO Branches (BranchName, Address) VALUES ('Central Branch', '123 Main St');

-- View all branches
SELECT * FROM Branches;

-- Update an employee's role
UPDATE Employees SET Role = 'Senior Manager' WHERE EmployeeID = 1;

-- Delete a customer
DELETE FROM Customers WHERE CustomerID = 2;



-- LOANOFFICER_USER CODE --
USE BankDB;

-- Add a new loan
INSERT INTO Loans (CustomerID, LoanType, PrincipalAmount, InterestRate) 
VALUES (1, 'Home Loan', 100000.00, 3.5);

-- View loans
SELECT * FROM Loans;

-- Add a loan payment
INSERT INTO LoanPayments (LoanID, AmountPaid) VALUES (1, 1000.00);



-- TELLER_USER CODE --

USE BankDB;

-- Record a new transaction
INSERT INTO Transactions (AccountID, TransactionType, Amount) VALUES (1, 'Deposit', 100.00);

-- View transactions
SELECT * FROM Transactions;

-- View account details
SELECT * FROM Accounts;


-- AUDITOR_USER --

Use BankDB;

-- View all customers
SELECT * FROM Customers;

-- View all transactions
SELECT * FROM Transactions;

-- View all accounts
SELECT * FROM Accounts;

-- Attempt to insert a record (this will fail)
INSERT INTO Customers (FirstName, LastName, Email) VALUES ('Test', 'Auditor', 'test.auditor@example.com');

-- CUSTOMER_USER --

USE BankDB;

-- Record a new transaction
INSERT INTO Transactions (AccountID, TransactionType, Amount) VALUES (1, 'Deposit', 100.00);

-- View transactions
SELECT * FROM Transactions;

-- View account details
SELECT * FROM Accounts;
