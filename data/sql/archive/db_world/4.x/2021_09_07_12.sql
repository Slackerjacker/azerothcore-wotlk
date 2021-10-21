-- DB update 2021_09_07_11 -> 2021_09_07_12
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_07_11';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_07_11 2021_09_07_12 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630927565231100667'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630927565231100667');

-- Remove Frost Oil from Vilebranch Witch Doctor, Tar Creeper, and Deadwood Gardener
DELETE FROM `creature_loot_template` WHERE `Entry` IN (2640, 6527, 7154) AND `Item` = 3829;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_07_12' WHERE sql_rev = '1630927565231100667';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;