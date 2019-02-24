INSERT INTO languages (id) VALUES (1);

INSERT INTO texts (id, language_id, text) VALUES
  (1, 1, 'Deutsch-Umgangssprache'),  (1, 2, 'German-Slang');

UPDATE languages SET text_id = id;

INSERT INTO achievementtypes (id, text_id_name, text_id_desc) VALUES (1, 'Spiel', 'Ein Spiel meint alle Spiele, egal ob digital oder physisch als Brettspiel.')
