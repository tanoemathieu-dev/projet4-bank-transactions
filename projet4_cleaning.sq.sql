CREATE DATABASE projet4;
USE projet4;
SELECT COUNT(*) FROM bank_transactions_data;
DESCRIBE bank_transactions_data;

SELECT -- Vérification des NULLs
    SUM(CASE WHEN TransactionID IS NULL THEN 1 ELSE 0 END)           AS null_TransactionID,
    SUM(CASE WHEN AccountID IS NULL THEN 1 ELSE 0 END)               AS null_AccountID,
    SUM(CASE WHEN TransactionAmount IS NULL THEN 1 ELSE 0 END)       AS null_TransactionAmount,
    SUM(CASE WHEN TransactionDate IS NULL THEN 1 ELSE 0 END)         AS null_TransactionDate,
    SUM(CASE WHEN TransactionType IS NULL THEN 1 ELSE 0 END)         AS null_TransactionType,
    SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END)                AS null_Location,
    SUM(CASE WHEN CustomerAge IS NULL THEN 1 ELSE 0 END)             AS null_CustomerAge,
    SUM(CASE WHEN CustomerOccupation IS NULL THEN 1 ELSE 0 END)      AS null_CustomerOccupation,
    SUM(CASE WHEN TransactionDuration IS NULL THEN 1 ELSE 0 END)     AS null_TransactionDuration,
    SUM(CASE WHEN LoginAttempts IS NULL THEN 1 ELSE 0 END)           AS null_LoginAttempts,
    SUM(CASE WHEN AccountBalance IS NULL THEN 1 ELSE 0 END)          AS null_AccountBalance,
    SUM(CASE WHEN PreviousTransactionDate IS NULL THEN 1 ELSE 0 END) AS null_PreviousTransactionDate
FROM bank_transactions_data;

SELECT TransactionID, COUNT(*) AS occurrences -- Vérification des doublons
FROM bank_transactions_data
GROUP BY TransactionID
HAVING COUNT(*) > 1;

SELECT --  Vérification des valeurs aberrantes
    MIN(TransactionAmount)   AS min_montant,
    MAX(TransactionAmount)   AS max_montant,
    MIN(CustomerAge)         AS min_age,
    MAX(CustomerAge)         AS max_age,
    MIN(LoginAttempts)       AS min_login,
    MAX(LoginAttempts)       AS max_login,
    MIN(AccountBalance)      AS min_solde,
    MAX(AccountBalance)      AS max_solde
FROM bank_transactions_data;

-- Vérifier les valeurs distinctes de chaque colonne catégorielle
SELECT DISTINCT TransactionType FROM bank_transactions_data ORDER BY 1;
SELECT DISTINCT Channel FROM bank_transactions_data ORDER BY 1;
SELECT DISTINCT CustomerOccupation FROM bank_transactions_data ORDER BY 1;
SELECT DISTINCT Location FROM bank_transactions_data ORDER BY 1;

CREATE TABLE bank_transactions_clean ( -- Création d'une table propre
    TransactionID           VARCHAR(10)    NOT NULL,
    AccountID               VARCHAR(10)    NOT NULL,
    TransactionAmount       DECIMAL(10,2)  NOT NULL,
    TransactionDate         DATETIME       NOT NULL,
    TransactionType         VARCHAR(10)    NOT NULL,
    Location                VARCHAR(50)    NOT NULL,
    DeviceID                VARCHAR(10)    NOT NULL,
    IPAddress               VARCHAR(20)    NOT NULL,
    MerchantID              VARCHAR(10)    NOT NULL,
    Channel                 VARCHAR(10)    NOT NULL,
    CustomerAge             TINYINT        NOT NULL,
    CustomerOccupation      VARCHAR(20)    NOT NULL,
    TransactionDuration     SMALLINT       NOT NULL,
    LoginAttempts           TINYINT        NOT NULL,
    AccountBalance          DECIMAL(10,2)  NOT NULL,
    PreviousTransactionDate DATETIME       NOT NULL,
    PRIMARY KEY (TransactionID)
);


INSERT INTO bank_transactions_clean --  Insertion des données nettoyées
SELECT
    TransactionID,
    AccountID,
    TransactionAmount,
    TransactionDate,
    TransactionType,
    Location,
    DeviceID,
    `IP Address`,
    MerchantID,
    Channel,
    CustomerAge,
    CustomerOccupation,
    TransactionDuration,
    LoginAttempts,
    AccountBalance,
    PreviousTransactionDate
FROM bank_transactions_data;

SELECT COUNT(*) FROM bank_transactions_clean;

