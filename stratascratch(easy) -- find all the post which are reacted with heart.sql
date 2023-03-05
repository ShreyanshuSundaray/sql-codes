/*
Find all posts which were reacted to with a heart.
 For such posts output all columns from facebook_posts table.

table1 -- facebook_reactions
poster:int
friend:int
reaction:varchar
date_day:int
post_id:int

table2 -- facebook_posts
post_id:int
poster:int
post_text:varchar
post_keywords:varchar
post_date:datetime

*/

SELECT DISTINCT
    fp.*
FROM
    facebook_reactions AS fr
        INNER JOIN
    facebook_posts AS fp ON fr.post_id = fp.post_id
WHERE
    reaction = 'heart';
