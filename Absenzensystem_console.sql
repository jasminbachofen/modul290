-- Datenbank erstellen
CREATE DATABASE IF NOT EXISTS SchoolDB;
USE SchoolDB;

-- Einen neuen Schüler zur Tabelle "Personen" hinzufügen
INSERT INTO Personen (Name, KlasseID) VALUES ('NeuerSchüler', 1);

-- Ein neues Datum zur Tabelle "Datum" hinzufügen
INSERT INTO Datum (Datum) VALUES ('2023-12-20');

-- Ein neues Fach zur Tabelle "Fach" hinzufügen
INSERT INTO Fach (Fach) VALUES ('Mathematik');

-- Einen neuen Timeslot zur Tabelle "Timeslots" hinzufügen
INSERT INTO Timeslots (Name, Timeslots) VALUES ('Erste Stunde', '08:00:00');

-- Einen neuen Status zur Tabelle "Status" hinzufügen
INSERT INTO Status (Status) VALUES ('Anwesend');

-- Den neuen Schüler zur "Absenzentabelle" hinzufügen
INSERT INTO Absenzentabelle (DatumID, FachID, TimeslotID, StatusID, PersonenID)
VALUES ((SELECT ID FROM Datum WHERE Datum = '2023-12-20' LIMIT 1), -- DatumID
        (SELECT ID FROM Fach WHERE Fach = 'Mathematik' LIMIT 1), -- FachID
        (SELECT ID FROM Timeslots WHERE Timeslots = '08:00:00' LIMIT 1), -- TimeslotID
        (SELECT ID FROM Status WHERE Status = 'Anwesend' LIMIT 1), -- StatusID
        (SELECT ID FROM Personen WHERE Name = 'NeuerSchüler' LIMIT 1) -- PersonenID
       );

-- Tabelle "Klasse" erstellen
CREATE TABLE IF NOT EXISTS Klasse (
                                      ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
                                      Name VARCHAR(255) NOT NULL
);

-- Werte in die Tabelle "Klasse" einfügen
INSERT INTO Klasse (Name) VALUES ('Klasse1'), ('Klasse2');

-- Tabelle "Personen" erstellen
CREATE TABLE IF NOT EXISTS Personen (
                                        ID INT AUTO_INCREMENT PRIMARY KEY,
                                        Name VARCHAR(255) NOT NULL,
                                        KlasseID INT,
                                        FOREIGN KEY (KlasseID) REFERENCES Klasse(ID)
);

-- Werte in die Tabelle "Personen" einfügen
INSERT INTO Personen (Name, KlasseID) VALUES ('Schüler1', 1), ('Schüler2', 1), ('Schüler3', 2);

SELECT Absenzentabelle.ID, Datum.Datum, Fach.Fach, Timeslots.Timeslots, Status.Status, Personen.Name AS Person
FROM Absenzentabelle
         JOIN Datum ON Absenzentabelle.DatumID = Datum.ID
         JOIN Fach ON Absenzentabelle.FachID = Fach.ID
         JOIN Timeslots ON Absenzentabelle.TimeslotID = Timeslots.ID
         JOIN Status ON Absenzentabelle.StatusID = Status.ID
         JOIN Personen ON Absenzentabelle.PersonenID = Personen.ID;



-- Tabelle "Klasse" erstellen
CREATE TABLE IF NOT EXISTS Klasse (
                                      ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
                                      Name VARCHAR(255) NOT NULL
);

-- Tabelle "Timeslots" erstellen
CREATE TABLE IF NOT EXISTS Timeslots (
                                         ID INT AUTO_INCREMENT PRIMARY KEY,
                                         Name VARCHAR(255) NOT NULL,
                                         Timeslots TIME NOT NULL
);

-- Tabelle "Personen" erstellen
CREATE TABLE IF NOT EXISTS Personen (
                                        ID INT AUTO_INCREMENT PRIMARY KEY,
                                        Name VARCHAR(255) NOT NULL,
                                        KlasseID INT,
                                        FOREIGN KEY (KlasseID) REFERENCES Klasse(ID)
);

-- Tabelle "Fach" erstellen
CREATE TABLE IF NOT EXISTS Fach (
                                    ID INT AUTO_INCREMENT PRIMARY KEY,
                                    Fach VARCHAR(255) NOT NULL
);

-- Tabelle "Status" erstellen
CREATE TABLE IF NOT EXISTS Status (
                                      ID INT AUTO_INCREMENT PRIMARY KEY,
                                      Status VARCHAR(255) NOT NULL
);

-- Tabelle "Datum" erstellen
CREATE TABLE IF NOT EXISTS Datum (
                                     ID INT AUTO_INCREMENT PRIMARY KEY,
                                     Datum DATE NOT NULL
);

-- Tabelle "Absenzentabelle" erstellen
CREATE TABLE IF NOT EXISTS Absenzentabelle (
                                               ID INT AUTO_INCREMENT PRIMARY KEY,
                                               DatumID INT,
                                               FachID INT,
                                               TimeslotID INT,
                                               StatusID INT,
                                               PersonenID INT,
                                               FOREIGN KEY (DatumID) REFERENCES Datum(ID),
                                               FOREIGN KEY (FachID) REFERENCES Fach(ID),
                                               FOREIGN KEY (TimeslotID) REFERENCES Timeslots(ID),
                                               FOREIGN KEY (StatusID) REFERENCES Status(ID),
                                               FOREIGN KEY (PersonenID) REFERENCES Personen(ID)
);


-- Create a new person
INSERT INTO Personen (Name, KlasseID) VALUES ('Zula', 1);

-- Read the person
SELECT * FROM Personen WHERE Name = 'Zula';

-- Update the person's name
UPDATE Personen SET Name = 'Angela' WHERE Name = 'Zula';
COMMIT;

-- Read the updated person
SELECT * FROM Personen WHERE Name = 'Angela';

-- Delete the person
DELETE FROM Personen WHERE Name = 'Angela';

-- Read to confirm deletion
SELECT * FROM Personen WHERE Name = 'Angela';