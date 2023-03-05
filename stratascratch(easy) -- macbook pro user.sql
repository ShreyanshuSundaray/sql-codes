/*
Count the number of user events performed by MacBookPro users.
Output the result along with the event name.
Sort the result based on the event count in the descending order.

Table: playbook_events

*/

SELECT 
    COUNT(event_name) AS event_count, event_name
FROM
    playbook_events
WHERE
    device = 'macbook pro'
GROUP BY event_name
ORDER BY COUNT(event_name) DESC;