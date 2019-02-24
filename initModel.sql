DROP TABLE IF EXISTS languages;
CREATE TABLE languages (
  id INTEGER,
  text_id INTEGER,
  CONSTRAINT languages_pk PRIMARY KEY (id),
  CONSTRAINT languages_texts_text_fk FOREIGN KEY (text_id) REFERENCES texts(id)
);

DROP TABLE IF EXISTS texts;
CREATE TABLE texts (
  id INTEGER NOT NULL,
  language_id INTEGER,
  text TEXT NOT NULL,
  CONSTRAINT texts_pk PRIMARY KEY (id, language_id),
  CONSTRAINT texts_languageid_text_uk UNIQUE (language_id, text),
  CONSTRAINT texts_languages_fk FOREIGN KEY (language_id) REFERENCES languages(id)
);

DROP TABLE IF EXISTS tagtypes;
CREATE TABLE tagtypes (
  id INTEGER,
  text_id_name INTEGER NOT NULL,
  text_id_desc INTEGER NOT NULL,
  CONSTRAINT tagtypes_pk PRIMARY KEY (id),
  CONSTRAINT tagtypes_texts_name_fk FOREIGN KEY (text_id_name) REFERENCES texts(id),
  CONSTRAINT tagtypes_texts_desc_fk FOREIGN KEY (text_id_desc) REFERENCES texts(id),
  CONSTRAINT tagtypes_name_uk UNIQUE (text_id_name)
  CONSTRAINT tagtypes_desc_uk UNIQUE (text_id_desc)
);

DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
  id INTEGER,
  text_id_name INTEGER NOT NULL,
  text_id_desc INTEGER NOT NULL,
  tagtype_id INTEGER NOT NULL,
  CONSTRAINT tags_pk PRIMARY KEY (id),
  CONSTRAINT tags_texts_name_fk FOREIGN KEY (text_id_name) REFERENCES texts(id),
  CONSTRAINT tags_texts_desc_fk FOREIGN KEY (text_id_desc) REFERENCES texts(id),
  CONSTRAINT tags_tagtypes_fk FOREIGN KEY (tagtype_id) REFERENCES tagtypes(id)
);

DROP TABLE IF EXISTS achievementtypes;
CREATE TABLE achievementtypes (
  id INTEGER,
  text_id_name INTEGER NOT NULL,
  text_id_desc INTEGER NOT NULL,
  CONSTRAINT achievementtypes_pk PRIMARY KEY (id),
  CONSTRAINT achievementtypes_texts_name_fk FOREIGN KEY (text_id_name) REFERENCES texts(id),
  CONSTRAINT achievementtypes_texts_desc_fk FOREIGN KEY (text_id_desc) REFERENCES texts(id),
  CONSTRAINT achievementtypes_name_uk UNIQUE (text_id_name),
  CONSTRAINT achievementtypes_desc_uk UNIQUE (text_id_desc)
);

DROP TABLE IF EXISTS achievements;
CREATE TABLE achievements (
  id INTEGER,
  achievementtype_id INTEGER NOT NULL,
  text_id_name INTEGER NOT NULL,
  text_id_desc INTEGER,
  achieved_at_day INTEGER,
  CONSTRAINT achievements_pk PRIMARY KEY (id),
  CONSTRAINT achievements_texts_name_fk FOREIGN KEY (text_id_name) REFERENCES texts(id),
  CONSTRAINT achievements_texts_desc_fk FOREIGN KEY (text_id_desc) REFERENCES texts(id),
  CONSTRAINT achievements_achievementtypes_fk FOREIGN KEY (achievementtype_id) REFERENCES achievementtypes(id),
  CONSTRAINT achievements_type_mame_uk UNIQUE (achievementtype_id, text_id_name)
);

DROP TABLE IF EXISTS k_achievements_tags;
CREATE TABLE k_achievements_tags (
  id INTEGER,
  achievement_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  CONSTRAINT kachievementstags_pk PRIMARY KEY (id),
  CONSTRAINT kachievementstags_achievements_fk FOREIGN KEY (achievement_id) REFERENCES achievements(id),
  CONSTRAINT kachievementstags_tags_fk FOREIGN KEY (tag_id) REFERENCES tags(id),
  CONSTRAINT kachievementstags_achivementid_tagid_uk UNIQUE (achievement_id, tag_id)
);
