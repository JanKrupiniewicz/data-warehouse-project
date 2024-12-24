USE HD_Data_Source;

BULK INSERT Sala
FROM 'C:\Users\jkrup\studia\HD\data-generator\next-level-school\Sala_T1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

BULK INSERT Wystawienie_Oceny
FROM 'C:\Users\jkrup\studia\HD\data-generator\next-level-school\Wystawienie_Oceny_T1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO