SELECT COUNT(distinct utm_campaign )
						AS 'Campaigns'
FROM page_visits;
                      
SELECT COUNT(distinct utm_source )
						AS 'Sources'
FROM page_visits;
                      
SELECT distinct utm_campaign, utm_source
FROM page_visits
ORDER BY 2;

SELECT distinct page_name
						AS 'Funnel'
FROM page_visits;

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT count(ft.user_id)
						AS 'FT Users',
            pv.utm_campaign
            AS 'Campaign'
FROM first_touch as ft
JOIN page_visits as pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY count(ft.user_id) desc;

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT count(lt.user_id)
						AS 'LT Users',
            pv.utm_campaign
            AS 'Campaign'
FROM last_touch as lt
JOIN page_visits as pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY count(lt.user_id) desc;

SELECT count(distinct user_id )
						AS 'Users on funnel step 4'
FROM page_visits
WHERE page_name = '4 - purchase';

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT count(lt.user_id)
							AS 'LT Users - step 4',
              pv.utm_campaign
              AS 'Campaign'
FROM last_touch as lt
JOIN page_visits as pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
WHERE pv.page_name = '4 - purchase'
GROUP BY pv.utm_campaign
ORDER BY count(lt.user_id) desc;

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT count(ft.user_id)
						AS 'FT Users',
            pv.utm_campaign
            AS 'Campaign',
            pv.utm_source
            AS 'Source'
FROM first_touch as ft
JOIN page_visits as pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY count(ft.user_id) desc;

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT count(lt.user_id)
							AS 'LT Users - step 4',
              pv.utm_campaign
              AS 'Campaign',
            pv.utm_source
            AS 'Source'
FROM last_touch as lt
JOIN page_visits as pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
WHERE pv.page_name = '4 - purchase'
GROUP BY pv.utm_campaign
ORDER BY count(lt.user_id) desc;