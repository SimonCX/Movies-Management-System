DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Rentals;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS WatchList;
DROP TABLE IF EXISTS Movies;

-- Table structure for table `Customers`

CREATE TABLE Customers (
  customerID int(11) NOT NULL AUTO_INCREMENT,
  firstName varchar(100) NOT NULL,
  lastName varchar(100) NOT NULL,
  email varchar(100) NOT NULL,
  phone varchar(15) NOT NULL,
  membershipExpireDate date NOT NULL,
  PRIMARY KEY (customerID),
  UNIQUE KEY email (email)
);

-- Dumping data for table `Customers`
INSERT INTO Customers
(
  firstName,
  lastName,
  email,
  phone,
  membershipExpireDate
)
VALUES 
('John','Smith','jsmith@example.com','123-456-7890','2025-03-15'),
('Emily','Johnson','ejohnson@example.com','555-234-5678','2024-12-01'),
('Micheal','Brown','mbrown@example.com','971-294-0960','2025-06-20'),
('Nick','Vu','vuni@oregonstate.edu','503-869-5525','2026-08-10');

-- Table structure for table `Employees`

CREATE TABLE Employees (
  employeeID int(11) NOT NULL AUTO_INCREMENT,
  firstName varchar(100) NOT NULL,
  lastName varchar(100) NOT NULL,
  position varchar(50) NOT NULL,
  hireDate date NOT NULL,
  PRIMARY KEY (employeeID)
);

-- Dumping data for table `Employees`
INSERT INTO Employees 
(
  firstName,
  lastName,
  position,
  hireDate
)
VALUES 
('Alice','Lee','Manager','2021-09-15'),
('Bob','Nguyen','Cashier','2019-09-20'),
('Carol','Martinez','Sale Associate','2015-08-18'),
('David','Chen','Sales Associate','2024-12-01');

-- Table structure for table `Movies`

CREATE TABLE Movies (
  movieID int(11) NOT NULL AUTO_INCREMENT,
  title varchar(255) NOT NULL,
  director varchar(100) NOT NULL,
  boxOfficeRating decimal(3,1) NOT NULL,
  releaseYear year(4) NOT NULL,
  genre varchar(50) NOT NULL,
  availableCopies int(11) NOT NULL,
  PRIMARY KEY (movieID)
);

-- Dumping data for table `Movies`
INSERT INTO Movies
(
  title,
  director, 
  boxOfficeRating, 
  releaseYear, 
  genre, 
  availableCopies
)
VALUES 
('Inception','Christopher Nolan',8.8,2010,'Sci-Fi',4),
('Cars 2','John Lasseter',7.2,2011,'Racing',9),
('Spirited Away','Hayao Miyazaki',8.4,2001,'Animation',5),
('The Martian','Andy Weir',9.1,2015,'Sci-Fi',12);

-- Table structure for table `Rentals`

CREATE TABLE Rentals (
  rentalID int(11) NOT NULL AUTO_INCREMENT,
  customerID int(11) NOT NULL,
  movieID int(11) NOT NULL,
  employeeID int(11) NOT NULL,
  rentalDate date NOT NULL,
  returnDate date DEFAULT NULL,
  status varchar(20) NOT NULL,
  PRIMARY KEY (rentalID),
  KEY customerID (customerID),
  KEY movieID (movieID),
  KEY employeeID (employeeID),
  FOREIGN KEY (customerID) REFERENCES Customers (customerID) ON DELETE CASCADE,
  FOREIGN KEY (movieID) REFERENCES Movies (movieID) ON DELETE CASCADE,
  FOREIGN KEY (employeeID) REFERENCES Employees (employeeID) ON DELETE CASCADE
);

-- Dumping data for table `Rentals`
INSERT INTO Rentals 
(
  customerID,
  movieID,
  employeeID,
  rentalDate,
  returnDate,
  status
)
VALUES 
(3,1,3,'2024-10-01','2024-10-08','returned'),
(1,2,2,'2024-10-05',NULL,'rented'),
(4,3,4,'2024-06-23','2024-07-02','returned'),
(2,4,1,'2024-10-27',NULL,'rented');

-- Table structure for table `WatchList`

CREATE TABLE WatchList (
  watchlistID int(11) NOT NULL AUTO_INCREMENT,
  customerID int(11) NOT NULL,
  movieID int(11) NOT NULL,
  dateAdded date NOT NULL,
  PRIMARY KEY (watchlistID),
  FOREIGN KEY (customerID) REFERENCES Customers (customerID) ON DELETE CASCADE,
  FOREIGN KEY (movieID) REFERENCES Movies (movieID) ON DELETE CASCADE
);

-- Dumping data for table `WatchList`
INSERT INTO WatchList 
(
  customerID,
  movieID,
  dateAdded
)
VALUES 
(1,2,'2024-09-15'),
(2,1,'2024-09-20'),
(3,4,'2023-07-10'),
(4,4,'2024-10-05');