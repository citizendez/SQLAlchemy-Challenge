/*THE THRILL OF THE CASE
build example table:
CREATE TABLE animal(
  ID SERIAL PRIMARY KEY,
  animal_name VARCHAR(50) NOT NULL,
  species VARCHAR(50) NOT NULL);

INSERT INTO animal (animal_name, species)
VALUES ('Mickey Mouse', 'duck'),
  ('Minnie Mouse', 'duck'),
  ('Donald Duck', 'mouse');*/
  
 SELECT *
 FROM animal;
 
SELECT *,
CASE
    WHEN species = 'duck' THEN 'mouse'
    WHEN species = 'mouse' THEN 'duck'
    ELSE species
END AS correct_species
FROM animal;