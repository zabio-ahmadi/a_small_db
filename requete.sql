


-- CRUD 
-- insertion : 
-- 1 
INSERT INTO User (email, password, is_email_verified)
VALUES ('malandain@hesge.ch', 'malandain_mot_de_pass', 1);
-- 2 
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id)
VALUES ('Stéphane', 'malandain', 'Male', 'profile.jpg', 'CH', 'Genève', 'demo adresse', 21);

-- 3 
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id)
VALUES (CURRENT_TIMESTAMP, 'My Post', 'This is my post content.', 'post.jpg', 1, 1);


-- update 
-- 4 
UPDATE User SET email = 'malandain@unige.ch' WHERE name = 'malandain';


-- delete 
-- 5 
-- DELETE FROM Posts WHERE post_id = 1;


-- 6 
-- first 10 users ordered by password ascending 
select * from User order by password ASC limit 10;

-- first 10 users after 10eme index ordered by email descending 
select * from User order by email DESC limit 10, 10;

-- 7 
-- verified users 
select * from user where is_email_verified = 1; 



-- select 

-- 8 
-- find the profil of verified users GROUP BY last_name 
select P.* from user U left join Profil P
	on U.user_id = P.user_id  
	GROUP BY P.last_name HAVING U.is_email_verified == 1;
	
-- 9
-- select published posts with coressponding user information 
SELECT P.*, U.email, U.is_email_verified
FROM Posts P 
JOIN User U ON P.user_id = U.user_id
WHERE P.is_published = 1;



-- select with joins 

-- 10 
-- select users with the same hobby name 
SELECT U.*
FROM User U 
JOIN user_has_hobby uhh ON U.user_id = uhh.user_id
JOIN Hobby H ON uhh.hobby_id = H.hobby_id
WHERE H.hobby_name = 'Reading';


-- 11 
-- select user with it's profession and hobby 
SELECT U.*, p.profession_name, h.hobby_name
FROM User U
LEFT JOIN user_has_profession UHP 
    ON U.user_id = UHP.user_id
LEFT JOIN Profession P 
    ON UHP.profession_id = P.profession_id

LEFT JOIN user_has_hobby UHH
    ON U.user_id = UHH.user_id
LEFT JOIN Hobby 
    ON UHH.hobby_id = H.hobby_id 

where Hobby.hobby_name  is not NULL;



-- 12 
-- select user, user profil who liked an specific posts 
SELECT U.*, Profil.name, Profil.last_name
FROM User U
JOIN Like L 
    ON U.user_id = L.user_id
JOIN Profil P 
    ON U.user_id = P.user_id
WHERE Like.post_id = 1;



-- 13 
-- select users, user detail who liked a specific posts and display the content of the post, comment
SELECT P.title, P.body, C.comment_body, U.*
FROM Posts P 
JOIN Comments C ON P.post_id = C.post_id
JOIN User U ON C.user_id = U.user_id
WHERE P.post_id = 1;

