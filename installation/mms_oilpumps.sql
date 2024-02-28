CREATE TABLE `mms_oilpumps` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`firstname` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`lastname` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`pumpname` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`stash` DOUBLE NOT NULL DEFAULT '0',
	`posx` FLOAT NULL DEFAULT NULL,
	`posy` FLOAT NULL DEFAULT NULL,
	`posz` FLOAT NULL DEFAULT NULL,
	`pumplevel` INT(11) NULL DEFAULT NULL,
	`prate` FLOAT NULL DEFAULT NULL,
	`ptime` FLOAT NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=36
;
