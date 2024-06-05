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
        const [capitalResult] = await connection.execute(
            'SELECT capital FROM countryCode WHERE name = ?',
            [countryX]
        );
        console.log('Capital:', capitalResult.length > 0 ? capitalResult[0].capital : 'Not found');

        // Query 2: 
        const regionY = await getUserInput('Enter the name of the region to list its languages: ');
        const [languagesResult] = await connection.execute(
            'SELECT DISTINCT cl.language FROM country_languages cl INNER JOIN countries c ON cl.country_code = c.code WHERE c.region = ?',
            [regionY]
        );
        console.log('Languages spoken in the region:', languagesResult.map(row => row.language).join(', '));

        // Query 3: 
        const languageZ = await getUserInput('Enter the language to find the number of cities it is spoken in: ');
        const [citiesResult] = await connection.execute(
            `SELECT COUNT(DISTINCT city) AS city_count
             FROM city_languages
             WHERE language = ?`,
            [languageZ]
        );
        console.log('Number of cities where the language is spoken:', citiesResult[0].city_count);

        // Query 4: 
        const countryForComparison = await getUserInput('Enter the name of the country for comparison: ');

        
        const [countryInfo] = await connection.execute(
            'SELECT official_language, continent FROM countries WHERE name = ?',
            [countryForComparison]
        );

        if (countryInfo.length > 0) {
            const officialLanguage = countryInfo[0].official_language;
            const continent = countryInfo[0].continent;

            const [sameLanguageAndContinentCountries] = await connection.execute(
                `SELECT name
                 FROM countries
                 WHERE official_language = ? AND continent = ? AND name != ?`,
                [officialLanguage, continent, countryForComparison]
            );

            if (sameLanguageAndContinentCountries.length > 0) {
                console.log('Countries with the same official language and on the same continent:', sameLanguageAndContinentCountries.map(row => row.name).join(', '));
            } else {
                console.log('FALSE');
            }
        } else {
            console.log('Country not found in the database.');
        }
    } catch (error) {
        console.error('Error executing queries:', error);
    } finally {
        await connection.end();
        closeInterface();
    }
};


main();
