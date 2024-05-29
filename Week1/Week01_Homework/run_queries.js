const mysql = require('mysql');
const fs = require('fs');
const path = require('path');


const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'kehara2011',
    database: 'new_world', 
    multipleStatements: true 
});


const sqlFilePath = path.join(__dirname, 'new_world_queries.sql'); 
const sqlQueries = fs.readFileSync(sqlFilePath, 'utf8');


connection.connect((err) => {
    if (err) throw err;
    console.log('Connected to MySQL');

    connection.query(sqlQueries, (err, results) => {
        if (err) throw err;
        
        results.forEach((result, index) => {
            console.log(`Results of Query ${index + 1}:`, result);
        });

        connection.end();
    });
});
