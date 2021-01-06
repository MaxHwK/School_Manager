DROP PROCEDURE IF EXISTS sp_moy_filiere; 

CREATE PROCEDURE sp_moy_filiere(IN f_code VARCHAR(10), OUT moy VARCHAR(5))
BEGIN
    DECLARE countEleves INT;   
    DECLARE i INT DEFAULT 0;          
    DECLARE tmpId INT;                  
    DECLARE tmpMoy VARCHAR(5) DEFAULT 0;  
    DECLARE curs1 CURSOR FOR (            
        SELECT e.id
        FROM ETUDIANT AS e
        JOIN FILIERE AS f
            ON (e.id_fil = f.id)
        WHERE code = f_code
    );

    SELECT COUNT(*) INTO countEleves
    FROM ETUDIANT AS e
    JOIN FILIERE AS f
        ON (e.id_fil = f.id)
    WHERE code = f_code;

    OPEN curs1;

    SET moy := 0;
    WHILE (i <> countEleves) DO
        FETCH curs1 INTO tmpId;
        CALL sp_moy_inscrit(tmpId, tmpMoy);
        SET moy := moy + REPLACE(tmpMoy,',','.') ;
        SET i := i + 1;
    END WHILE;

    CLOSE curs1;

    IF(countEleves <> 0) THEN
        SET moy := REPLACE(FORMAT(moy / countEleves,2),'.',',');
    ELSE
        SET moy := -1;
    END IF;
END;
