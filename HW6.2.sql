DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello(input_time TIME)
RETURNS VARCHAR(25) DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(25);
	
	CASE
		WHEN input_time BETWEEN '06:00:00' AND '11:59:59'
			THEN SET result = 'Доброе утро';
		WHEN input_time BETWEEN '12:00:00' AND '17:59:59'
			THEN SET result = 'Добрый день';
		WHEN input_time BETWEEN '18:00:00' AND '23:59:59'
			THEN SET result = 'Добрый вечер';
		ELSE SET result = 'Доброй ночи';
	END CASE;
	
	RETURN result;
	
END //

DELIMITER ;