CREATE TABLE `mms_oilpumps` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`firstname` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`lastname` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`pumpname` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`stash` INT(11) NOT NULL DEFAULT '0',
	`posx` FLOAT NULL DEFAULT NULL,
	`posy` FLOAT NULL DEFAULT NULL,
	`posz` FLOAT NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=3
;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('OilPump', 'Öl Pumpe', 1, 1, 'item_standard', 1);
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('oil', 'Öl', 50, 1, 'item_standard', 1);