DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS photos;
DROP TABLE IF EXISTS comments;


CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  username VARCHAR(255) NOT NULL
);

CREATE TABLE photos (
  id INTEGER PRIMARY KEY,
  caption VARCHAR(255),
  user_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES user(id)
);

CREATE TABLE comments (
  id INTEGER PRIMARY KEY,
  body VARCHAR(255) NOT NULL, 
  photo_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES user(id),
  FOREIGN KEY(photo_id) REFERENCES photo(id)
);

INSERT INTO 
  users (id, username)
VALUES
  (1, "Kevin"), (2, "Jacob"), (3, "Emily");

INSERT INTO 
  photos (id, caption, user_id)
VALUES 
  (1, "Hello Kevin!", 1),
  (2, "Hello Jacob!", 2),
  (3, "Bye Jacob!", 2),
  (4, "Hello Emily!!", 3),
  (5, "Morning Emily!", 3),
  (6, "Bye Emily!", 3);

INSERT INTO 
  comments (id, body, photo_id, user_id)
VALUES 
  (1, "This is Kevin on Photo 1", 1, 1),
  (2, "This is Kevin on Photo 2", 2, 1),
  (3, "This is Kevin on Photo 5", 5, 1),
  (4, "This is Jacob on Photo 1", 1, 2),
  (5, "This is Jacob on Photo 3", 3, 2),
  (6, "This is Jacob on Photo 4", 4, 2),
  (7, "This is Emily on Photo 5", 5, 3),
  (8, "This is Emily on Photo 2", 2, 3),
  (9, "This is Emily on Photo 6", 6, 3);
