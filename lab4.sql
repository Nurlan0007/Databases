create database lab4;

create table warehouses (
    code serial primary key,
    location varchar(255),
    capacity integer
);

create table boxes (
    code varchar(4) primary key,
    contents varchar(255),
    value real,
    warehouse integer,
    foreign key (warehouse) references warehouses(code)
);

INSERT INTO Warehouses (location, capacity) VALUES
( 'Chicago', 3 ),
( 'Chicago', 4 ),
( 'New York', 7 ),
( 'Los Angeles', 5 ),
( 'San Francisco', 8 );

INSERT INTO Boxes (code, contents, value, warehouse) VALUES
('OM7', 'Rocks', 180, 3),
('4B8P', 'Rocks', 250, 1),
('4T3T', 'Scissors', 190, 4),
('7G3H', 'Rocks', 200, 1),
('8N6', 'Papers', 75, 1),
('8V6U', 'Papers', 50, 3),
('9F6F', 'Papers', 175, 2),
('LL8B', 'Rocks', 140, 4),
('P0H6', 'Scissors', 125, 1),
('P216', 'Scissors', 150, 2),
('TU55', 'Papers', 90, 5);


SELECT * FROM Warehouses;

SELECT * FROM Boxes
WHERE value > 150;

SELECT DISTINCT contents FROM Boxes;

SELECT warehouse, COUNT(*) AS box_count
FROM Boxes
GROUP BY warehouse;

SELECT warehouse, COUNT(*) AS box_count
FROM Boxes


GROUP BY warehouse
HAVING COUNT(*) > 2;

INSERT INTO Warehouses (location, capacity) VALUES ('New York', 3);

INSERT INTO Boxes (code, contents, value, warehouse) VALUES ('H5RT', 'Papers', 200, 2);

UPDATE Boxes
SET value = value * 0.85
WHERE code IN (
    SELECT code FROM Boxes
    ORDER BY value DESC
    LIMIT 1 OFFSET 2
);

DELETE FROM Boxes
WHERE value < 150;

DELETE FROM Boxes
USING Warehouses
WHERE Boxes.warehouse = Warehouses.code
AND Warehouses.location = 'New York'
RETURNING Boxes.*;
