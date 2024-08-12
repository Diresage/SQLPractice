

-- Open and Execute this SQL file in SQL Server Management Studio to create the tables used in the Stored Procedure Challenges:


USE SAMPLEDB
GO


CREATE TABLE oes.bank_accounts 
(
	account_id INT IDENTITY,
	account_name VARCHAR(50) NOT NULL,
	balance DECIMAL(30,2),
CONSTRAINT pk_bank_accounts_account_id PRIMARY KEY (account_id),
CONSTRAINT chk_bank_accounts_balance CHECK (balance >= 0)
);


INSERT INTO oes.bank_accounts (account_name, balance) VALUES ('Anna', 3400);
INSERT INTO oes.bank_accounts (account_name, balance) VALUES ('Bob', 2400);
INSERT INTO oes.bank_accounts (account_name, balance) VALUES ('Sandra', 2800);
INSERT INTO oes.bank_accounts (account_name, balance) VALUES ('Abdul', 3200);




CREATE TABLE oes.bank_transactions
(
	tr_id INT IDENTITY,
	tr_datetime datetime2 DEFAULT GETDATE(),
	from_account_id INT,
	to_account_id INT,
	amount DECIMAL(30,2),
CONSTRAINT pk_transactions_transaction_id PRIMARY KEY (tr_id),
CONSTRAINT fk_transactions_from_account_id FOREIGN KEY (from_account_id)
	REFERENCES oes.bank_accounts(account_id),
CONSTRAINT fk_transactions_to_account_id FOREIGN KEY (to_account_id)
	REFERENCES oes.bank_accounts(account_id)
);



INSERT INTO oes.bank_transactions (from_account_id, to_account_id, amount) VALUES (4, 3, 150);
INSERT INTO oes.bank_transactions (from_account_id, to_account_id, amount) VALUES (1, 4, 92.5);










