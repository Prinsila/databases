DELIMITER //

CREATE TRIGGER notify_language_count
AFTER INSERT ON CountryLanguage
FOR EACH ROW
BEGIN
    DECLARE lang_count INT;

    -- Count the number of languages for the country of the newly inserted row
    SELECT COUNT(*) INTO lang_count
    FROM CountryLanguage
    WHERE country_code = NEW.country_code;

    -- Check if the count is 10 or more
    IF lang_count >= 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Notification: The country now has 10 or more languages.';
    END IF;
END //

DELIMITER ;
