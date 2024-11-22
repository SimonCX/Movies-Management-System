/*
    SETUP
*/
require('dotenv').config(); // For sercurity purpose, load environment variables from .env
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3598
const db = require('./db-connector'); // Database connection

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(express.static('public'));

/*
    ROUTES
*/

// Homepage Route
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/public/index.html');
});

// CRUD Routes for Movies
// READ
app.get('/movies', (req, res) => {
    const query = 'SELECT movieID, title, director, boxOfficeRating, releaseYear, genre, availableCopies FROM Movies;';
    db.pool.query(query, (err, results) => {
        if (err) {
            console.error('Database query error:', err);
            res.status(500).send('Database query error');
        } else {
            res.json(results); // Return movies as JSON
        }
    });
});

// CREATE
app.post('/add_movie', (req, res) => {
    const { title, director, boxOfficeRating, releaseYear, genre, availableCopies } = req.body;
    const query = `
        INSERT INTO Movies (title, director, boxOfficeRating, releaseYear, genre, availableCopies)
        VALUES (?, ?, ?, ?, ?, ?);
    `;
    db.pool.query(query, [title, director, boxOfficeRating, releaseYear, genre, availableCopies], (err) => {
        if (err) {
            console.error('Database query error:', err);
            res.status(500).send('Database query error');
        } else {
            res.redirect('/manage_movies.html');
        }
    });
});

// DELETE
app.post('/delete_movie', (req, res) => {
    const { movieID } = req.body;
    const query = 'DELETE FROM Movies WHERE movieID = ?;';
    db.pool.query(query, [movieID], (err) => {
        if (err) {
            console.error('Database query error:', err);
            res.status(500).send('Database query error');
        } else {
            res.redirect('/manage_movies.html');
        }
    });
});

// UPDATE
app.post('/update_movie', (req, res) => {
    const { movieID, title, director, boxOfficeRating, releaseYear, genre, availableCopies } = req.body;
    const query = `
        UPDATE Movies
        SET title = ?, director = ?, boxOfficeRating = ?, releaseYear = ?, genre = ?, availableCopies = ?
        WHERE movieID = ?;
    `;
    db.pool.query(query, [title, director, boxOfficeRating, releaseYear, genre, availableCopies, movieID], (err) => {
        if (err) {
            console.error('Database query error:', err);
            res.status(500).send('Database query error');
        } else {
            res.redirect('/manage_movies.html');
        }
    });
});


/*
    LISTENER
*/
app.listen(PORT, () => {
    console.log(`Server is running on http://classwork.engr.oregonstate.edu:${PORT}`);
});
