const mysql = require('mysql2/promise');
const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const dbConfig = {
    host: 'localhost',
    user: 'root',
    password: 'kehara2011',
    database: 'new_world'
};

const getUserInput = (query) => {
    return new Promise((resolve) => rl.question(query, resolve));
};

const closeInterface = () => rl.close();

const main = async () => {
    const connection = await mysql.createConnection(dbConfig);

    try {
        // Query 1:
        const countryX = await getUserInput('Enter the name of the countryCode to find its capital: ');
        const [capitalStmt] = await connection.prepare(
            'SELECT capital FROM countryCode WHERE name = ?'
        );
        const [capitalResult] = await capitalStmt.execute([countryX]);
        await capitalStmt.deallocate();
        console.log('Capital:', capitalResult.length > 0 ? capitalResult[0].capital : 'Not found');

        // Query 2: 
        const regionY = await getUserInput('Enter the name of the region to list its languages: ');
        const [languagesStmt] = await connection.prepare(
            'SELECT DISTINCT cl.language FROM country_languages cl INNER JOIN countries c ON cl.country_code = c.code WHERE c.region = ?'
        );
        const [languagesResult] = await languagesStmt.execute([regionY]);
        await languagesStmt.deallocate();
        console.log('Languages spoken in the region:', languagesResult.map(row => row.language).join(', '));

        // Query 3: 
        const languageZ = await getUserInput('Enter the language to find the number of cities it is spoken in: ');
        const [citiesStmt] = await connection.prepare(
            `SELECT COUNT(DISTINCT city) AS city_count
             FROM city_languages
             WHERE language = ?`
        );
        const [citiesResult] = await citiesStmt.execute([languageZ]);
        await citiesStmt.deallocate();
        console.log('Number of cities where the language is spoken:', citiesResult[0].city_count);

        // Query 4: 
        const countryForComparison = await getUserInput('Enter the name of the country for comparison: ');

        const [comparisonStmt] = await connection.prepare(
            `SELECT name
             FROM countries
             WHERE official_language = (SELECT official_language FROM countries WHERE name = ?)
             AND continent = (SELECT continent FROM countries WHERE name = ?)
             AND name != ?`
        );
        const [sameLanguageAndContinentCountries] = await comparisonStmt.execute([countryForComparison, countryForComparison, countryForComparison]);
        await comparisonStmt.deallocate();

        if (sameLanguageAndContinentCountries.length > 0) {
            console.log('Countries with the same official language and on the same continent:', sameLanguageAndContinentCountries.map(row => row.name).join(', '));
        } else {
            console.log('FALSE');
        }

    } catch (error) {
        console.error('Error executing queries:', error);
    } finally {
        await connection.end();
        closeInterface();
    }
};

main();
