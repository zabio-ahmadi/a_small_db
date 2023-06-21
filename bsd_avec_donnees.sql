-- -----------------------------------------------------
-- DATABASE social
-- -----------------------------------------------------

 -----------------------------------------------------
-- Table `social`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `User`;

CREATE TABLE IF NOT EXISTS `User` (
  `user_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `email` TEXT NOT NULL UNIQUE,
  `password` TEXT NOT NULL,
  `is_email_verified` INTEGER NOT NULL DEFAULT 0
);

CREATE UNIQUE INDEX IF NOT EXISTS `user_email_index` ON `User` (`email`);

-- -----------------------------------------------------
-- Table `social`.`Profil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Profil`;

CREATE TABLE IF NOT EXISTS `Profil` (
  `profil_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT NOT NULL,
  `last_name` TEXT NOT NULL,
  `gender` VARCHAR(16) NOT NULL,
  `profil_image` TEXT NULL,
  `country` TEXT NOT NULL,
  `city` TEXT NOT NULL,
  `address` TEXT NOT NULL,
  `user_id` INTEGER NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`)
);

-- -----------------------------------------------------
-- Table `social`.`posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Posts`;

CREATE TABLE IF NOT EXISTS `Posts` (
  `post_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `created_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `title` TEXT NOT NULL,
  `body` TEXT NOT NULL,
  `image_url` TEXT NOT NULL,
  `is_published` INTEGER NOT NULL,
  `user_id` INTEGER NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`)
);

-- -----------------------------------------------------
-- Table `social`.`Comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comments`;

CREATE TABLE IF NOT EXISTS `Comments` (
  `comment_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `comment_body` TEXT NOT NULL,
  `post_id` INTEGER NOT NULL,
  `user_id` INTEGER NOT NULL,
  FOREIGN KEY (`post_id`) REFERENCES `Posts` (`post_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`)
);



-- -----------------------------------------------------
-- Table `social`.`like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Like`;

CREATE TABLE IF NOT EXISTS `Like` (
  `like_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `user_id` INTEGER NOT NULL,
  `post_id` INTEGER NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
  FOREIGN KEY (`post_id`) REFERENCES `Posts` (`post_id`)
);

-- -----------------------------------------------------
-- Table `social`.`hobbies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hobby`;

CREATE TABLE IF NOT EXISTS `Hobby` (
  `hobby_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `hobby_name` TEXT NOT NULL UNIQUE
);

CREATE UNIQUE INDEX IF NOT EXISTS `hobby_name_index` ON Hobby (`hobby_name`);


-- -----------------------------------------------------
-- Table `social`.`user_has_hobby`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_hobby`;

CREATE TABLE IF NOT EXISTS `user_has_hobby` (
  `user_id` INTEGER NOT NULL,
  `hobby_id` INTEGER NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
  FOREIGN KEY (`hobby_id`) REFERENCES `Hobby` (`hobby_id`)
);


-- -----------------------------------------------------
-- Table `social`.`Profession`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Profession`;

CREATE TABLE IF NOT EXISTS `Profession` (
  `profession_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `profession_name` TEXT NOT NULL UNIQUE
);

CREATE UNIQUE INDEX IF NOT EXISTS `profession_name_index` ON Profession (`profession_name`);


-- -----------------------------------------------------
-- Table `social`.`user_has_profession`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_profession`;

CREATE TABLE IF NOT EXISTS `user_has_profession` (
  `user_id` INTEGER NOT NULL,
  `profession_id` INTEGER NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
  FOREIGN KEY (`profession_id`) REFERENCES `Profession` (`profession_id`)
);





-- -----------------------------------------------------
-- Table `social`.`user_has_friend
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_friend`;

CREATE TABLE IF NOT EXISTS `user_has_friend` (
  `user_id1` INTEGER NOT NULL,
  `user_id2` INTEGER NOT NULL,
  FOREIGN KEY (`user_id1`) REFERENCES `User` (`user_id`),
  FOREIGN KEY (`user_id2`) REFERENCES `User` (`user_id`)
);




-- Trigger to update `is_published` column when inserting a new post
-- constraint non modelisable 
-- vérifie la date d'une publications si la date est dans la future donc mets la valeur à la date actuel + mets la valeur de is_published à false 
CREATE TRIGGER IF NOT EXISTS `update_created_date_trigger`
AFTER INSERT ON `Posts`
BEGIN
  UPDATE `Posts`
  SET `created_date` = CASE
    WHEN `created_date` > CURRENT_TIMESTAMP THEN CURRENT_TIMESTAMP
    ELSE `created_date`
    END,
    `is_published` = CASE
    WHEN `created_date` <= CURRENT_TIMESTAMP THEN NEW.is_published
    ELSE 0
    END
  WHERE `post_id` = NEW.`post_id`;
END;





-- -----------------------------------------------------
-- DATA 
-- -----------------------------------------------------

-- Table User :
INSERT INTO User (email, password, is_email_verified) VALUES ('user1@example.com', 'password1', 1);
INSERT INTO User (email, password, is_email_verified) VALUES ('user2@example.com', 'password2', 1);
INSERT INTO User (email, password, is_email_verified) VALUES ('user3@example.com', 'password3', 0);
INSERT INTO User (email, password, is_email_verified) VALUES ('user4@example.com', 'password4', 1);
INSERT INTO User (email, password, is_email_verified) VALUES ('user5@example.com', 'password5', 1);
INSERT INTO User (email, password, is_email_verified) VALUES ('user6@example.com', 'password6', 0);
INSERT INTO User (email, password, is_email_verified) VALUES ('user7@example.com', 'password7', 1);
INSERT INTO User (email, password, is_email_verified) VALUES ('user8@example.com', 'password8', 0);
INSERT INTO User (email, password, is_email_verified) VALUES ('user9@example.com', 'password9', 1);
INSERT INTO User (email, password, is_email_verified) VALUES ('user10@example.com', 'password10', 1);
INSERT INTO User (email, password, is_email_verified) VALUES ('user11@example.com', 'password11', 0);
INSERT INTO User (email, password, is_email_verified) VALUES ('user12@example.com', 'password12', 1);
INSERT INTO User (email, password, is_email_verified) VALUES ('user13@example.com', 'password13', 1);
INSERT INTO User (email, password, is_email_verified) VALUES ('user14@example.com', 'password14', 0);
INSERT INTO User (email, password, is_email_verified) VALUES ('user15@example.com', 'password15', 1);
INSERT INTO User (email, password, is_email_verified) VALUES ('user16@example.com', 'password16', 0);
INSERT INTO User (email, password, is_email_verified) VALUES ('user17@example.com', 'password17', 1);
INSERT INTO User (email, password, is_email_verified) VALUES ('user18@example.com', 'password18', 0);
INSERT INTO User (email, password, is_email_verified) VALUES ('user19@example.com', 'password19', 1);
INSERT INTO User (email, password, is_email_verified) VALUES ('user20@example.com', 'password20', 1);

INSERT INTO user_has_friend (user_id1, user_id2) VALUES (1, 2);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (1, 3);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (2, 4);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (2, 5);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (3, 6);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (3, 7);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (4, 8);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (4, 9);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (5, 10);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (5, 11);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (6, 12);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (6, 13);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (7, 14);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (7, 15);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (8, 16);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (8, 17);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (9, 18);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (9, 19);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (10, 20);
INSERT INTO user_has_friend (user_id1, user_id2) VALUES (10, 1);


-- Table Profil :

INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('John', 'Doe', 'Male', 'image1.jpg', 'USA', 'New York', '123 Main St', 1);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Jane', 'Smith', 'Female', 'image2.jpg', 'USA', 'Los Angeles', '456 Elm St', 2);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Michael', 'Johnson', 'Male', NULL, 'Canada', 'Toronto', '789 Oak St', 3);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Emily', 'Brown', 'Female', 'image3.jpg', 'UK', 'London', '12 Maple St', 4);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('David', 'Wilson', 'Male', 'image4.jpg', 'Australia', 'Sydney', '34 Pine St', 5);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Emma', 'Davis', 'Female', 'image5.jpg', 'USA', 'Chicago', '56 Cedar St', 6);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Matthew', 'Anderson', 'Male', NULL, 'USA', 'Houston', '78 Walnut St', 7);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Olivia', 'Miller', 'Female', 'image6.jpg', 'Canada', 'Vancouver', '90 Oak St', 8);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Daniel', 'Taylor', 'Male', 'image7.jpg', 'UK', 'Manchester', '23 Elm St', 9);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Sophia', 'Johnson', 'Female', NULL, 'USA', 'San Francisco', '45 Maple St', 10);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Aiden', 'Brown', 'Male', 'image8.jpg', 'Australia', 'Melbourne', '67 Pine St', 11);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Mia', 'Garcia', 'Female', 'image9.jpg', 'USA', 'Seattle', '89 Cedar St', 12);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Ethan', 'Martinez', 'Male', NULL, 'USA', 'Dallas', '12 Walnut St', 13);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Isabella', 'Jones', 'Female', 'image10.jpg', 'Canada', 'Montreal', '34 Oak St', 14);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Alexander', 'Thomas', 'Male', 'image11.jpg', 'UK', 'Birmingham', '56 Elm St', 15);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Charlotte', 'Harris', 'Female', NULL, 'USA', 'Miami', '78 Maple St', 16);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('James', 'Clark', 'Male', 'image12.jpg', 'Australia', 'Brisbane', '90 Pine St', 17);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Sophia', 'King', 'Female', 'image13.jpg', 'USA', 'Austin', '23 Cedar St', 18);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Benjamin', 'Young', 'Male', NULL, 'Canada', 'Calgary', '45 Elm St', 19);
INSERT INTO Profil (name, last_name, gender, profil_image, country, city, address, user_id) VALUES ('Amelia', 'Lee', 'Female', 'image14.jpg', 'UK', 'Glasgow', '67 Maple St', 20);

-- Table Posts :
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-20 09:00:00', 'Post 1', 'This is the first post', 'image1.jpg', 1, 1);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-19 14:30:00', 'Post 2', 'This is the second post', 'image2.jpg', 1, 2);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-18 20:45:00', 'Post 3', 'This is the third post', 'image3.jpg', 0, 3);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-17 10:15:00', 'Post 4', 'This is the fourth post', 'image4.jpg', 1, 4);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-16 15:20:00', 'Post 5', 'This is the fifth post', 'image5.jpg', 1, 5);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-15 08:45:00', 'Post 6', 'This is the sixth post', 'image6.jpg', 0, 6);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-14 18:30:00', 'Post 7', 'This is the seventh post', 'image7.jpg', 1, 7);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-13 12:00:00', 'Post 8', 'This is the eighth post', 'image8.jpg', 0, 8);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-12 09:30:00', 'Post 9', 'This is the ninth post', 'image9.jpg', 1, 9);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-11 16:45:00', 'Post 10', 'This is the tenth post', 'image10.jpg', 1, 10);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-10 11:15:00', 'Post 11', 'This is the eleventh post', 'image11.jpg', 0, 11);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-09 19:30:00', 'Post 12', 'This is the twelfth post', 'image12.jpg', 1, 12);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-08 14:00:00', 'Post 13', 'This is the thirteenth post', 'image13.jpg', 1, 13);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-07 10:30:00', 'Post 14', 'This is the fourteenth post', 'image14.jpg', 0, 14);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-06 17:45:00', 'Post 15', 'This is the fifteenth post', 'image15.jpg', 1, 15);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-05 12:15:00', 'Post 16', 'This is the sixteenth post', 'image16.jpg', 0, 16);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-04 20:30:00', 'Post 17', 'This is the seventeenth post', 'image17.jpg', 1, 17);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-03 15:45:00', 'Post 18', 'This is the eighteenth post', 'image18.jpg', 1, 18);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-02 09:00:00', 'Post 19', 'This is the nineteenth post', 'image19.jpg', 0, 19);
INSERT INTO Posts (created_date, title, body, image_url, is_published, user_id) VALUES ('2023-06-01 17:15:00', 'Post 20', 'This is the twentieth post', 'image20.jpg', 1, 20);


-- Table Comments :
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Great post!', 1, 1);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('I agree with you.', 1, 2);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Nice article.', 2, 3);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Well written.', 2, 4);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Interesting post.', 3, 5);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Thanks for sharing.', 3, 6);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Good job!', 4, 7);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('I enjoyed reading this.', 4, 8);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Keep up the good work.', 5, 9);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Looking forward to more.', 5, 10);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Nice post!', 6, 11);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('I found this helpful.', 6, 12);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Well said.', 7, 13);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('I have a question.', 7, 14);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Interesting insights.', 8, 15);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('I learned something new.', 8, 16);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Great points!', 9, 17);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('I appreciate your perspective.', 9, 18);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('Well done!', 10, 19);
INSERT INTO Comments (comment_body, post_id, user_id) VALUES ('This inspired me.', 10, 20);


-- Table Like :

INSERT INTO Like (user_id, post_id) VALUES (1, 1);
INSERT INTO Like (user_id, post_id) VALUES (2, 1);
INSERT INTO Like (user_id, post_id) VALUES (3, 2);
INSERT INTO Like (user_id, post_id) VALUES (4, 2);
INSERT INTO Like (user_id, post_id) VALUES (5, 3);
INSERT INTO Like (user_id, post_id) VALUES (6, 3);
INSERT INTO Like (user_id, post_id) VALUES (7, 4);
INSERT INTO Like (user_id, post_id) VALUES (8, 4);
INSERT INTO Like (user_id, post_id) VALUES (9, 5);
INSERT INTO Like (user_id, post_id) VALUES (10, 5);
INSERT INTO Like (user_id, post_id) VALUES (11, 6);
INSERT INTO Like (user_id, post_id) VALUES (12, 6);
INSERT INTO Like (user_id, post_id) VALUES (13, 7);
INSERT INTO Like (user_id, post_id) VALUES (14, 7);
INSERT INTO Like (user_id, post_id) VALUES (15, 8);
INSERT INTO Like (user_id, post_id) VALUES (16, 8);
INSERT INTO Like (user_id, post_id) VALUES (17, 9);
INSERT INTO Like (user_id, post_id) VALUES (18, 9);
INSERT INTO Like (user_id, post_id) VALUES (19, 10);
INSERT INTO Like (user_id, post_id) VALUES (20, 10);

--Table Hobby :
INSERT INTO Hobby (hobby_name) VALUES ('Reading');
INSERT INTO Hobby (hobby_name) VALUES ('Gardening');
INSERT INTO Hobby (hobby_name) VALUES ('Cooking');
INSERT INTO Hobby (hobby_name) VALUES ('Photography');
INSERT INTO Hobby (hobby_name) VALUES ('Painting');
INSERT INTO Hobby (hobby_name) VALUES ('Sports');
INSERT INTO Hobby (hobby_name) VALUES ('Music');
INSERT INTO Hobby (hobby_name) VALUES ('Traveling');
INSERT INTO Hobby (hobby_name) VALUES ('Dancing');
INSERT INTO Hobby (hobby_name) VALUES ('Writing');
INSERT INTO Hobby (hobby_name) VALUES ('Drawing');
INSERT INTO Hobby (hobby_name) VALUES ('Hiking');
INSERT INTO Hobby (hobby_name) VALUES ('Yoga');
INSERT INTO Hobby (hobby_name) VALUES ('Singing');
INSERT INTO Hobby (hobby_name) VALUES ('Cycling');
INSERT INTO Hobby (hobby_name) VALUES ('Film-making');
INSERT INTO Hobby (hobby_name) VALUES ('Chess');
INSERT INTO Hobby (hobby_name) VALUES ('Fashion');
INSERT INTO Hobby (hobby_name) VALUES ('Volunteering');
INSERT INTO Hobby (hobby_name) VALUES ('Fitness');

-- Table user_has_hobby :
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (1, 1);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (1, 2);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (2, 3);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (2, 4);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (3, 5);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (3, 6);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (4, 7);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (4, 8);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (5, 9);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (5, 10);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (6, 11);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (6, 12);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (7, 13);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (7, 14);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (8, 15);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (8, 16);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (9, 17);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (9, 18);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (10, 19);
INSERT INTO user_has_hobby (user_id, hobby_id) VALUES (10, 20);

-- Table Profession :

INSERT INTO Profession (profession_name) VALUES ('Teacher');
INSERT INTO Profession (profession_name) VALUES ('Engineer');
INSERT INTO Profession (profession_name) VALUES ('Doctor');
INSERT INTO Profession (profession_name) VALUES ('Lawyer');
INSERT INTO Profession (profession_name) VALUES ('Artist');
INSERT INTO Profession (profession_name) VALUES ('Writer');
INSERT INTO Profession (profession_name) VALUES ('Designer');
INSERT INTO Profession (profession_name) VALUES ('Developer');
INSERT INTO Profession (profession_name) VALUES ('Accountant');
INSERT INTO Profession (profession_name) VALUES ('Manager');
INSERT INTO Profession (profession_name) VALUES ('Chef');
INSERT INTO Profession (profession_name) VALUES ('Nurse');
INSERT INTO Profession (profession_name) VALUES ('Entrepreneur');
INSERT INTO Profession (profession_name) VALUES ('Salesperson');
INSERT INTO Profession (profession_name) VALUES ('Architect');
INSERT INTO Profession (profession_name) VALUES ('Consultant');
INSERT INTO Profession (profession_name) VALUES ('Musician');
INSERT INTO Profession (profession_name) VALUES ('Pilot');
INSERT INTO Profession (profession_name) VALUES ('Scientist');
INSERT INTO Profession (profession_name) VALUES ('Photographer');

-- Table user_has_profession :

INSERT INTO user_has_profession (user_id, profession_id) VALUES (1, 1);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (1, 2);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (2, 3);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (2, 4);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (3, 5);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (3, 6);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (4, 7);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (4, 8);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (5, 9);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (5, 10);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (6, 11);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (6, 12);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (7, 13);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (7, 14);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (8, 15);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (8, 16);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (9, 17);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (9, 18);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (10, 19);
INSERT INTO user_has_profession (user_id, profession_id) VALUES (10, 20);

