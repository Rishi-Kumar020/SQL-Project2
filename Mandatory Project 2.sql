use ig_clone;
-- 2)We want to reward the user who has been around the longest, Find the 5 oldest users.
select id,username,min(created_at) as oldest_users from users group by id order by created_at limit 5;

-- 3)To target inactive users in an email ad campaign, find the users who have never posted a photo.
select * from users;
select * from photos;
select users.id,users.username from users left join photos on users.id = photos.user_id where photos.user_id is null order by id;
select id,username from users where id not in (select user_id from photos) order by id;

-- 4)Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
select * from users;
select * from photos;
select * from likes;
select username,photos.id,photos.image_url,count(*) as max_likes
from photos inner join likes on likes.photo_id = photos.id inner join users on photos.user_id = users.id
group by photos.id order by max_likes desc limit 1;

-- 5)The investors want to know how many times does the average user post.
select * from users;
select * from photos;
select round((select count(*) from photos)/(select count(*) from users),2) as avg_post_by_user;

-- 6)A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select * from tags;
select * from photo_tags;
select tag_id,tag_name,count(*) as tag_count from tags inner join photo_tags on tags.id = photo_tags.tag_id 
group by tag_id order by tag_count desc limit 5;

-- 7)To find out if there are bots, find users who have liked every single photo on the site. 
select * from users;
select * from likes;
select u.id,u.username,count(u.id) as users_liked_every_photo
from users u join likes l on u.id = l.user_id group by u.id having users_liked_every_photo = (select count(*) from photos);

-- 8)Find the users who have created instagramid in may and select top 5 newest joinees from it?
select * from users;
select * from users where monthname(created_at) = "may" order by created_at desc limit 5;

-- 9)Can you help me find the users whose name starts with c 
-- and ends with any number and have posted the photos as well as liked the photos? 
select * from users;
select * from users where username regexp "^c.*$" ;
select users.id,users.username from users inner join photos on users.id = photos.user_id 
inner join likes on photos.id = likes.photo_id
where users.username regexp "^c.*$" group by id order by id;

select username,photos.id,photos.image_url
from photos inner join likes on likes.photo_id = photos.id 
inner join users on photos.user_id = users.id 
where users.username regexp "^c.*$" group by id;

select * from users where username regexp "^c.*[0-9]$" and id in (select distinct user_id from photos 
where user_id in (select distinct user_id from likes));

-- 10)Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
select * from photos;
select * from users;
select id,username from users where id in (select user_id from photos) order by id limit 30;

select users.id,users.username from users left join photos on users.id = photos.user_id where photos.user_id is null order by id;
select id,username from users where id not in (select user_id from photos) order by id;

select u.id,u.username,count(p.id) as num_photos from users u inner join photos p on u.id = p.user_id
group by u.username having num_photos between 3 and 5 order by num_photos desc limit 30;