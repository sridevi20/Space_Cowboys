DROP TABLE IF EXISTS Bounty_Tracks;

CREATE TABLE  Bounty_Tracks (
 id SERIAL PRIMARY KEY,
 name VARCHAR(255),
 species VARCHAR(255),
 bounty INT,
 danger_level VARCHAR(255)
 );
