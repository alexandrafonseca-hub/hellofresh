Hello 👋!
Thank you for progressing your application to the next step, the following is a test we’ve created to understand your level of SQL experience. This is also designed to help you understand the type of analytical work you would be doing at HelloFresh.
Please only spend 4 hours maximum on the test. Please submit your solution to ocho@hellofresh.com. Best of luck!

# Case Description
The customer care team at HelloFresh utilises SQL to generate reports that allow them to understand about the interactions between our agents and the customers, so that we can always improve on our product offering and process. Below is a use-case that shows a query utilised to generate Keywords based on the notes written by the customer care agents during interactions.

## Data
Given the following table structures:

`customer_conversations`(
conversation_id BIGINT,
agent_email STRING,
agent_department STRING,
wrap_up_name STRING,
wrap_up_note STRING,
media_type STRING,
queue_name STRING,
country STRING,
originating_direction STRING,
fk_conversation_start_date INT,
fk_customer_id BIGINT)

`dates` (
date_id INT,
hellofresh_week STRING,
iso_week STRING,
date_string STRING,
quarter INT,
year INT)

`customers` (
customer_id BIGINT,
country STRING,
customer_since INT)

`entities` (
entity_id INT,
country STRING, country_group STRING)

## The Test
Based on the case description above and information below:

1. Provide the necessary changes to the query below, that would improve its performance and readability
2. Describe the steps you took to improve it - what was the reasoning behind any change, why it works best than the current one
3. Explain how you would measure the improvements

## Important Information
1. All the business logic should remain the same - filters and groups should be respected (the output data should be the same)
2. Number of records in each table:
   Customer_conversations = 150.000.000 (150 million rows)
   Customers = 1.000.000 (1 million rows)
   Dates = 5.000 (5 thousand rows
   Entities = 500 (five hundred rows)
3. All tables might have additional columns, which are not necessary in this example
4. All tables are clean and have no duplicate records
5. The combination of customer and country is unique
6. Dates are stored in an INT field, with format as YYYYMMDD
7. Dates.hellofresh_week follows the format YYYY-W00 (e.g: 2020-W01 = first week of 2020)
8. Dates.iso_week follows the format W00 (e.g: W01, first week of the calendar year)
9. Dates.date_string follows the format YYYY-MM-DD
10. Customer_conversations data is stored in a partitioned table, with country as a partition column.

Query

`SELECT DISTINCT c.customer_id, ed.country,
gc.queue_name, dd.hellofresh_week, dd.iso_week, dd.date_string, dd.quarter,
dd.year, gc.agent_email,

gc.agent_department, gc.wrap_up_name, gc.wrap_up_note, gc.conversation_id, gc.media_type,
CASE
WHEN Lower(gc.wrap_up_note) LIKE '%virus%'
THEN 'Coronavirus'
WHEN Lower(gc.wrap_up_note) LIKE '%coronavirus%'
THEN'Coronavirus'
WHEN Lower(gc.wrap_up_note) LIKE '% covid%' THEN 'Coronavirus' WHEN ed.country_group = 'BENELUXFR'
AND gc.wrap_up_name = 'Payments - Refund'
AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'
WHEN ed.country_group = 'BENELUXFR'
AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
WHEN ed.country_group = 'BENELUXFR'
AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Paid'
WHEN ed.country_group = 'BENELUXFR'
AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%'
THEN 'Payment plan'
WHEN ed.country_group = 'BENELUXFR'
AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'
WHEN ed.country_group = 'BENELUXFR'
AND gc.wrap_up_name = 'Payments - Other'
AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'
WHEN ed.country_group = 'BENELUXFR'
AND Lower(gc.wrap_up_note) LIKE '%email%' THEN 'Email'
WHEN ed.country_group = 'BENELUXFR'
AND Lower(gc.wrap_up_note) LIKE '%e-mail%' THEN 'Email'
WHEN ed.country_group = 'BENELUXFR'
AND Lower(gc.wrap_up_note) LIKE '%e mail%' THEN 'Email'
WHEN ed.country_group = 'BENELUXFR'
AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
WHEN ed.country_group = 'BENELUXFR'
AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'

WHEN ed.country_group IN ( 'AU', 'NZ' )
AND gc.wrap_up_name = 'Payments - Refund'
AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'
WHEN ed.country_group IN ( 'AU', 'NZ' )
AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
WHEN ed.country_group IN ( 'AU', 'NZ' )
AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Paid'
WHEN ed.country_group IN ( 'AU', 'NZ' )
AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%'
THEN 'Payment plan'
WHEN ed.country_group IN ( 'AU', 'NZ' )
AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%'
THEN 'Manual payment'
WHEN ed.country_group IN ( 'AU', 'NZ' )
AND gc.wrap_up_name = 'Payments - Other'
AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'
WHEN ed.country_group IN ( 'AU', 'NZ' )
AND Lower(gc.wrap_up_note) LIKE '%email%' THEN 'Email'
WHEN ed.country_group IN ( 'AU', 'NZ' )
AND Lower(gc.wrap_up_note) LIKE '%e-mail%' THEN 'Email'
WHEN ed.country_group IN ( 'AU', 'NZ' )
AND Lower(gc.wrap_up_note) LIKE '%e mail%' THEN 'Email'
WHEN ed.country_group IN ( 'AU', 'NZ' )
AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
WHEN ed.country_group IN ( 'AU', 'NZ' )
AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'
WHEN ed.country_group = 'UK'
AND gc.wrap_up_name = 'Payments - Refund'
AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN
'Refund not received'
WHEN ed.country_group = 'UK'
AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
WHEN ed.country_group = 'UK'
AND gc.wrap_up_name = 'Payments - Reactivation'

AND Lower(gc.wrap_up_note) LIKE '%paid%'
THEN 'Paid'
WHEN ed.country_group = 'UK'
AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'
WHEN ed.country_group = 'UK'
AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'
WHEN ed.country_group = 'UK'
AND gc.wrap_up_name = 'Payments - Other'
AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'
WHEN ed.country_group = 'UK'
AND Lower(gc.wrap_up_note) LIKE '%email%' THEN 'Email'
WHEN ed.country_group = 'UK'
AND Lower(gc.wrap_up_note) LIKE '%e-mail%' THEN 'Email'
WHEN ed.country_group = 'UK'
AND Lower(gc.wrap_up_note) LIKE '%e mail%' THEN 'Email'
WHEN ed.country_group = 'UK'
AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
WHEN ed.country_group = 'UK'
AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'
ELSE 'Other' END AS 'Keyword'
FROM customer_conversationsASgc LEFT JOIN dates AS dd
ON gc.fk_conversation_start_date = dd.date_id LEFT JOIN customers AS cd
ON gc.fk_customer_id = c.customer_id
LEFT JOIN(SELECT DISTINCT country,
CASE
WHEN country IN ( 'GB', 'UK' ) THEN 'UK' WHEN country IN ( 'EP', 'ER', 'GC' ) THEN 'US' ELSE country
END AS 'new_country'
FROM customer_conversationsASgc)ASnc
ON gc.country = nc.country
LEFT JOIN entities AS ed
ON nc.new_country = ed.country
WHERE participant_purpose = 'agent'
AND gc.originating_direction = 'inbound' AND country_group <> 'US'
GROUP BY c.customer_id,

ed.country, gc.queue_name, dd.hellofresh_week, dd.iso_week, dd.date_string, dd.quarter,
dd.year, gc.agent_email, gc.agent_department, gc.wrap_up_name, gc.wrap_up_note, gc.conversation_id, gc.media_type`
