DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old LIKE users;

ALTER TABLE users_old
MODIFY COLUMN id BIGINT UNSIGNED NOT NULL UNIQUE;

DROP PROCEDURE IF EXISTS move_user_to_old;
DELIMITER //
CREATE PROCEDURE move_user_to_old(user_id BIGINT)
BEGIN
	DECLARE `_rollback` BIT DEFAULT b'0';
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
 		SET `_rollback` = b'1';
	END;
	
	START TRANSACTION;
	INSERT INTO users_old (id, firstname, lastname, email)
	SELECT id, firstname, lastname, email FROM users u
	WHERE u.id = user_id;
	
	DELETE FROM users u
	WHERE u.id = user_id;
	
	IF `_rollback` THEN
		SELECT 'ROLLBACK';
		ROLLBACK;
	ELSE
		SELECT 'COMMIT';
		COMMIT;
	END IF;	
END //
DELIMITER ;

CALL move_user_to_old(1);