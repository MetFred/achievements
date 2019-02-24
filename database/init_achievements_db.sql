BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS `texts` (
	`id`	INTEGER NOT NULL,
	`language_id`	INTEGER NOT NULL,
	`text`	TEXT NOT NULL,
	PRIMARY KEY(`id`,`language_id`),
	FOREIGN KEY(`language_id`) REFERENCES `languages`(`id`)
);
CREATE TABLE IF NOT EXISTS `tags` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`text_id_name`	INTEGER NOT NULL UNIQUE,
	`text_id_description`	INTEGER NOT NULL UNIQUE,
	FOREIGN KEY(`text_id_name`) REFERENCES `texts`(`id`),
	FOREIGN KEY(`text_id_description`) REFERENCES `texts`(`id`)
);
CREATE TABLE IF NOT EXISTS `platforms` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`text_id_name`	INTEGER NOT NULL UNIQUE,
	`text_id_description`	INTEGER NOT NULL UNIQUE,
	FOREIGN KEY(`text_id_description`) REFERENCES `texts`(`id`),
	FOREIGN KEY(`text_id_name`) REFERENCES `texts`(`id`)
);
CREATE TABLE IF NOT EXISTS `languages` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`text_id_name`	INTEGER UNIQUE
);
CREATE TABLE IF NOT EXISTS `k_games_tags` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`game_id`	INTEGER NOT NULL,
	`tag_id`	INTEGER NOT NULL,
	FOREIGN KEY(`tag_id`) REFERENCES `tags`(`id`),
	FOREIGN KEY(`game_id`) REFERENCES `games`(`id`)
);
CREATE TABLE IF NOT EXISTS `k_games_platforms` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`game_id`	INTEGER NOT NULL,
	`platform_id`	INTEGER NOT NULL,
	`release`	TEXT NOT NULL,
	FOREIGN KEY(`platform_id`) REFERENCES `platforms`(`id`),
	FOREIGN KEY(`game_id`) REFERENCES `games`(`id`)
);
CREATE TABLE IF NOT EXISTS `k_games_genres` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`game_id`	INTEGER NOT NULL,
	`genre_id`	INTEGER NOT NULL,
	FOREIGN KEY(`genre_id`) REFERENCES `genres`(`id`),
	FOREIGN KEY(`game_id`) REFERENCES `games`(`id`)
);
CREATE TABLE IF NOT EXISTS `k_games_controls` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`game_id`	INTEGER NOT NULL,
	`control_id`	INTEGER NOT NULL,
	FOREIGN KEY(`game_id`) REFERENCES `games`(`id`),
	FOREIGN KEY(`control_id`) REFERENCES `controls`(`id`)
);
CREATE TABLE IF NOT EXISTS `genres` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`text_id_name`	INTEGER NOT NULL UNIQUE,
	`text_id_description`	INTEGER NOT NULL UNIQUE,
	FOREIGN KEY(`text_id_description`) REFERENCES `texts`(`id`),
	FOREIGN KEY(`text_id_name`) REFERENCES `texts`(`id`)
);
CREATE TABLE IF NOT EXISTS `games` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`text_id_name`	INTEGER NOT NULL UNIQUE,
	`text_id_description`	INTEGER NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS `controls` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`text_id_name`	INTEGER NOT NULL UNIQUE,
	`text_id_description`	INTEGER NOT NULL UNIQUE,
	FOREIGN KEY(`text_id_name`) REFERENCES `texts`(`id`),
	FOREIGN KEY(`text_id_description`) REFERENCES `texts`(`id`)
);
COMMIT;
