--Data Manipulation Queries for Project Implementation

-- Entites: Customers, Employees, Movies, Rentals, and WatchLists

--DISPLAY: get all customers information such as customerID, fistName, lastName, email, phone, membershipExpireDate 
--to display of the customers browse page
SELECT customerID, firstName, lastName, email, phone, membershipExpireDate
FROM Customers;

--DISPLAY: get all the Employees information for the Employees page
SELECT employeeID, firstName, lastName, position, hireDate
FROM Employees;

--DISPLAY: get all the Movies information for the Movies page
SELECT movieID, title, director, boxOfficeRating, releaseYear, genre, availableCopies
FROM Movies;

--DISPLAY: get all the Rentals information for the Rentals page
SELECT rentalID, Customers.firstName AS customer, Movies.title AS movie, Employees.firstName AS employee, rentalDate, returnDate, status
FROM Rentals
INNER JOIN Customers ON Rentals.customerID = Customers.customerID
INNER JOIN Movies ON Rentals.movieID = Movies.movieID
INNER JOIN Employees ON Rentals.employeeID = Employees.employeeID
ORDER BY rentalID DESC;


--CREATE: add a new customer
INSERT INTO Customers (firstName, lastName, email, phone, membershipExpireDate)
VALUES
(
    :fnameInput,
    :lnameInput,
    :emailInput,
    :phoneInput,
    :membershipExpireDateInput
);

--CREATE: add new employee
INSERT INTO Employees (firstName, lastName, position, hireDate)
VALUES
(
    :fnameInput,
    :lnameInput,
    :position_from_dropdown_input,
    :hireDateInput
);

--CREATE: add new movie
INSERT INTO Movies (title, director, boxOfficeRating, releaseYear, genere, availableCopies)
VALUES
(
    :titleInput,
    :directorInput,
    :boxOfficeRatingInput,
    :releaseYearInput,
    :genreInput,
    :availableCopiesInput
);

--CREATE: add new rental trnasaction
INSERT INTO Rentals (customerID, movieID, employeeID, rentalDate, returnDate, status)
VALUES
(
    :customerIDInput_from_dropdown,
    :movieIDInput_from_dropdown,
    :employeeIDInput_from_dropdown,
    :rentalDateInput, 
    :returnDateInput,
    :statusInput
);

--Associate a customer with a movie (M:M)
INSERT INTO WatchLists (customerID, movieID, dateAdded)
VALUES
(
    :customerIDInput_from_dropdown,
    :movieIDInput_from_dropdown,
    :dateAddedInput
);

--DELETE: delete a customer
DELETE FROM Customers WHERE customerID = :customer_ID_from_browse;

--DELETE: delete a employee
DELETE FROM Employees WHERE employeeID = :employee_ID_from_browse;

--DELETE: delete a movie
DELETE FROM Movies WHERE movieID = :movie_ID_from_browse;

--DELETE: delete a movie from a watchlist
DELETE FROM WatchLists WHERE movieID = :movie_ID_from_watchlist_browse 
AND customerID = customer_ID_from_watchlist_browse;

--UPDATE: update a customer
UPDATE Customers 
SET firstName = :firstNameInput, lastName = :lastNameInput, email = :emailInput, phone = :phoneInput, membershipExpireDate = :membershipExpireDate
WHERE customerID = :customer_ID_from_the_broswe;

--UPDATE: update a employee:
UPDATE Employees
SET firstName = :firstNameInput, lastName = :lastNameInput, position = :positionInput, hireDate = :hireDateInput
WHERE employeeID = :employee_ID_from_the_browse;

--UPDATE: update a movie
UPDATE Movies
SET title = :titleInput, director = :directorInput, boxOfficeRating = :boxOfficeRatingInput, releaseYear = :releaseYearInput, genre = :genreInput, availableCopies = :availableCopiesInput
WHERE movieID = :movie_ID_from_the_browse;