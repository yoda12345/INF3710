DROP SCHEMA IF EXISTS hotel CASCADE;
CREATE SCHEMA hotel;

SET search_path = hotel;

--
--  Création des tables
--

CREATE TABLE Hotel (
hotelNum      SMALLINT NOT NULL, 
hotelName     VARCHAR(25) NOT NULL, 
city          VARCHAR(15) NOT NULL, 
CONSTRAINT hotel_PK
       PRIMARY KEY (hotelNum)
);

CREATE TABLE Guest (
clientID      CHAR(4) NOT NULL, 
NAS           VARCHAR(25) NOT NULL, 
clientName    VARCHAR(15) NOT NULL, 
sex           CHAR(1) DEFAULT 'M', 
age           SMALLINT NOT NULL, -- Useless?
city          VARCHAR(8) NOT NULL, -- Useless?
CONSTRAINT guest_AK
       UNIQUE (NAS),
CONSTRAINT guest_PK
       PRIMARY KEY (clientID)
);

CREATE TABLE Room (
roomNum       SMALLINT NOT NULL,
roomHotelNum  SMALLINT NOT NULL,
roomType      CHAR(6) NOT NULL,
roomPrice     DECIMAL NOT NULL,
CONSTRAINT room_PK
       PRIMARY KEY (roomNum), -- Partial
CONSTRAINT Room_Hotel_FK
       FOREIGN KEY (roomHotelNum)
       REFERENCES Hotel(hotelNum)
)

CREATE TABLE Booking (
clientID      VARCHAR(7) NOT NULL, 
hotelNum      VARCHAR(8) NOT NULL,
roomNum       VARCHAR(8) NOT NULL,  
arrivalDate   DATE NOT NULL, 
departurelDate   DATE NOT NULL, 
CONSTRAINT booking_PK
       PRIMARY KEY (clientID, hotelNum, roomNum, arrivalDate, departurelDate), -- Composite and partial
CONSTRAINT Booking_Hotel_FK 
       FOREIGN KEY (hotelNum) 
       REFERENCES Hotel(hotelNum),
CONSTRAINT Booking_Client_FK 
       FOREIGN KEY (clientID) 
       REFERENCES Guest(clientID),
CONSTRAINT Booking_Room_FK
       FOREIGN KEY (roomNum)
       REFERENCES Room(roomNum)
);

-- Insertion de données

INSERT INTO Hotel VALUES ('H111', 'Grosvenor Hotel',   'London',   'SW1 4EH');
INSERT INTO Hotel VALUES ('H112', 'Kingston Hotel', 'Kingston');
INSERT INTO Hotel VALUES ('H113', 'Hotel des pas perdus', 'Montreal');

INSERT INTO Room VALUES ('1', 'H111', 'S', 72.00);
INSERT INTO Room VALUES ('2', 'H111', 'S', 100.00);
INSERT INTO Room VALUES ('3', 'H111', 'D', 200.00);
INSERT INTO Room VALUES ('1', 'H112', 'D', 450.00);

INSERT INTO Guest VALUES ('G111', 'John Smith', 'London');
INSERT INTO Guest VALUES ('G112', 'Alex L', 'Kingston');
INSERT INTO Guest VALUES ('G113', 'Idris S', 'Montreal');
INSERT INTO Guest VALUES ('G114', 'Guillaume D', 'Quebec');

INSERT INTO Booking VALUES ('H111', 'G111', DATE'2016-03-01', DATE'2016-04-04', '1');
INSERT INTO Booking VALUES ('H111', 'G114', DATE'2016-03-01', DATE'2016-03-05', '3');
INSERT INTO Booking VALUES ('H111', 'G116', DATE'2016-03-04', DATE'2016-01-06', '4');
