USE pet_adoption;

SELECT s.name AS shelter_name,
       (SELECT COUNT(*) FROM pet p WHERE p.shelter_id = s.shelter_id) AS pet_count
FROM shelter s;

SELECT name, species, age
FROM pet
WHERE age > (SELECT AVG(age) FROM pet WHERE age IS NOT NULL);

SELECT s.name AS shelter_name
FROM shelter s
WHERE EXISTS (
    SELECT 1
    FROM pet p
    JOIN adoption ad ON p.pet_id = ad.pet_id
    WHERE p.shelter_id = s.shelter_id
);

SELECT a.first_name, a.last_name
FROM adopter a
WHERE a.adopter_id IN (
    SELECT ad.adopter_id
    FROM adoption ad
    JOIN pet p ON ad.pet_id = p.pet_id
    WHERE p.species = 'cat'
);

SELECT p.name, p.species, ad.adoption_date
FROM pet p
JOIN adoption ad ON p.pet_id = ad.pet_id
WHERE ad.adoption_date > (
    SELECT AVG(ad2.adoption_date)
    FROM adoption ad2
);

SELECT species, COUNT(*) AS available_pet_count
FROM (
    SELECT p.species
    FROM pet p
    WHERE p.status = 'available'
) AS available_pets
GROUP BY species;

SELECT p.name, p.species,
       (SELECT COUNT(*) FROM adoption ad WHERE ad.pet_id = p.pet_id) AS adoption_count
FROM pet p;