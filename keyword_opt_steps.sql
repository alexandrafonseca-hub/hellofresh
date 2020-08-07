
-- BEFORE ANYTHING
-- Worked the layout of the table
-- Give a naming to all the tables and columns (nc.bla)



-- FIRST
-- Have one line per keyword

SELECT DISTINCT c.customer_id
	, ed.country
	, gc.queue_name
	, dd.hellofresh_week
	, dd.iso_week
	, dd.date_string
	, dd.quarter
	, dd.year
	, gc.agent_email
	, gc.agent_department
	, gc.wrap_up_name
	, gc.wrap_up_note
	, gc.conversation_id
	, gc.media_type
	
	, CASE
		-- assumption is that corona only does not appear (if corona always coronavirus)
		WHEN Lower(gc.wrap_up_note) LIKE '%virus%' OR Lower(gc.wrap_up_note) LIKE '%covid%' THEN 'Coronavirus'

		--WHEN Lower(gc.wrap_up_note) LIKE '%virus%' THEN 'Coronavirus'
		--WHEN Lower(gc.wrap_up_note) LIKE '%coronavirus%' THEN 'Coronavirus'
		--WHEN Lower(gc.wrap_up_note) LIKE '% covid%' THEN 'Coronavirus' 
		
		-- 'Refund not received'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'

		--WHEN ed.country_group = 'BENELUXFR' AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'
		--WHEN ed.country_group IN ( 'AU', 'NZ' ) AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'
		--WHEN ed.country_group = 'UK' AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'

		-- 'Not paid'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'

		--WHEN ed.country_group = 'BENELUXFR' AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
		--WHEN ed.country_group IN ( 'AU', 'NZ' ) AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
		--WHEN ed.country_group = 'UK' AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'

		-- 'Paid'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Not paid'

		--WHEN ed.country_group = 'BENELUXFR' AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Paid'
		--WHEN ed.country_group IN ( 'AU', 'NZ' ) AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Paid'
		--WHEN ed.country_group = 'UK' AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Paid'

		
		-- Payment plan
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'

		--WHEN ed.country_group = 'BENELUXFR' AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'
		--WHEN ed.country_group IN ( 'AU', 'NZ' ) AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'
		--WHEN ed.country_group = 'UK' AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'

		
		-- 'Manual payment'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'

		--WHEN ed.country_group = 'BENELUXFR' AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'
		--WHEN ed.country_group IN ( 'AU', 'NZ' ) AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'
		--WHEN ed.country_group = 'UK' AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment' 

		
		-- 'Overview'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'

		--WHEN ed.country_group = 'BENELUXFR' AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'
		--WHEN ed.country_group IN ( 'AU', 'NZ' ) AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'
		--WHEN ed.country_group = 'UK' AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'

		-- Email
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
													)
		--WHEN ed.country_group = 'BENELUXFR' AND Lower(gc.wrap_up_note) LIKE '%email%' THEN 'Email'
		--WHEN ed.country_group = 'BENELUXFR' AND Lower(gc.wrap_up_note) LIKE '%e-mail%' THEN 'Email'
		--WHEN ed.country_group = 'BENELUXFR' AND Lower(gc.wrap_up_note) LIKE '%e mail%' THEN 'Email'
		--WHEN ed.country_group = 'BENELUXFR' AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
		--WHEN ed.country_group IN ( 'AU', 'NZ' ) AND Lower(gc.wrap_up_note) LIKE '%email%' THEN 'Email'
		--WHEN ed.country_group IN ( 'AU', 'NZ' ) AND Lower(gc.wrap_up_note) LIKE '%e-mail%' THEN 'Email'
		--WHEN ed.country_group IN ( 'AU', 'NZ' ) AND Lower(gc.wrap_up_note) LIKE '%e mail%' THEN 'Email'
		--WHEN ed.country_group IN ( 'AU', 'NZ' ) AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
		--WHEN ed.country_group = 'UK' AND Lower(gc.wrap_up_note) LIKE '%email%' THEN 'Email'
		--WHEN ed.country_group = 'UK' AND Lower(gc.wrap_up_note) LIKE '%e-mail%' THEN 'Email'
		--WHEN ed.country_group = 'UK' AND Lower(gc.wrap_up_note) LIKE '%e mail%' THEN 'Email'
		--WHEN ed.country_group = 'UK' AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'

		-- GDPR
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'

		--WHEN ed.country_group = 'BENELUXFR' AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'
		--WHEN ed.country_group IN ( 'AU', 'NZ' ) AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'
		--WHEN ed.country_group = 'UK' AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'

		
	ELSE 'Other'
	END AS 'Keyword'

FROM customer_conversationsASgc

LEFT JOIN dates AS dd ON gc.fk_conversation_start_date = dd.date_id

LEFT JOIN customers AS cd ON gc.fk_customer_id = c.customer_id

LEFT JOIN
	(
		SELECT DISTINCT country,
				CASE WHEN country IN ( 'GB', 'UK' ) THEN 'UK' WHEN country IN ( 'EP', 'ER', 'GC' ) THEN 'US' ELSE country
				END AS 'new_country'

		FROM customer_conversationsASgc
	)AS nc
		ON gc.country = nc.country

LEFT JOIN entities AS ed ON nc.new_country = ed.country

WHERE participant_purpose = 'agent'
	AND gc.originating_direction = 'inbound'
	AND country_group <> 'US'
				
GROUP BY c.customer_id,
	,ed.country
	, gc.queue_name
	, dd.hellofresh_week
	, dd.iso_week
	, dd.date_string
	, dd.quarter
	, dd.year
	, gc.agent_email
	, gc.agent_department
	, gc.wrap_up_name
	, gc.wrap_up_note
	, gc.conversation_id
	, gc.media_type



-- SECOND
-- There are more countries outside of the US AND ('AU','NZ','BENELUXFR','UK') otherwise, we would exclude the country from the key words
-- Example, if there is Italy


SELECT DISTINCT c.customer_id
	, ed.country
	, gc.queue_name
	, dd.hellofresh_week
	, dd.iso_week
	, dd.date_string
	, dd.quarter
	, dd.year
	, gc.agent_email
	, gc.agent_department
	, gc.wrap_up_name
	, gc.wrap_up_note
	, gc.conversation_id
	, gc.media_type
	
	, CASE
		WHEN Lower(gc.wrap_up_note) LIKE '%virus%' OR Lower(gc.wrap_up_note) LIKE '%covid%' THEN 'Coronavirus'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Not paid'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'
	ELSE 'Other'
	END AS 'Keyword'

FROM customer_conversations AS gc

LEFT JOIN dates AS dd ON gc.fk_conversation_start_date = dd.date_id

LEFT JOIN customers AS cd ON gc.fk_customer_id = c.customer_id

LEFT JOIN
	(
		SELECT DISTINCT country,
				CASE 
					WHEN country IN ( 'GB', 'UK' ) THEN 'UK' 
					WHEN country IN ( 'EP', 'ER', 'GC' ) THEN 'US'
					ELSE country
				END AS 'new_country'

		FROM customer_conversationsASgc
	)AS nc
		ON gc.country = nc.country

LEFT JOIN entities AS ed ON nc.new_country = ed.country

WHERE participant_purpose = 'agent'
	AND gc.originating_direction = 'inbound'
	AND country_group <> 'US'
				
GROUP BY c.customer_id,
	,ed.country
	, gc.queue_name
	, dd.hellofresh_week
	, dd.iso_week
	, dd.date_string
	, dd.quarter
	, dd.year
	, gc.agent_email
	, gc.agent_department
	, gc.wrap_up_name
	, gc.wrap_up_note
	, gc.conversation_id
	, gc.media_type



-- THIRD
-- Reduce the processed data (Filter 15M table)


with customer_conversations_v2 as 
	( 
		SELECT DISTINCT conversation_id
			, agent_email
			, agent_department
			, wrap_up_name
			, wrap_up_note
			, media_type
			, queue_name
			, originating_direction
			, fk_conversation_start_date
			, fk_customer_id 

			-- reduce rows by country group
			, CASE 
				WHEN country IN ( 'GB', 'UK' ) THEN 'UK' ELSE country END AS 'new_country'

		FROM customer_conversations 

-- assumption: only countries in the country_group US are 'EP', 'ER', 'GC' 
-- assumption: participant_purpose comes from this table, is one of the columns that were not mentioned BUT is necessary IF in fact is not necessary then ignore this row

		WHERE country NOT IN ( 'EP', 'ER', 'GC' )
			and originating_direction = 'inbound'
			and participant_purpose = 'agent'

	)




SELECT DISTINCT c.customer_id
	, ed.country
	, gc.queue_name
	, dd.hellofresh_week
	, dd.iso_week
	, dd.date_string
	, dd.quarter
	, dd.year
	, gc.agent_email
	, gc.agent_department
	, gc.wrap_up_name
	, gc.wrap_up_note
	, gc.conversation_id
	, gc.media_type
	
	, CASE
		WHEN Lower(gc.wrap_up_note) LIKE '%virus%' OR Lower(gc.wrap_up_note) LIKE '%covid%' THEN 'Coronavirus'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Not paid'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'
	ELSE 'Other'
	END AS 'Keyword'

FROM customer_conversations_v2 AS gc

LEFT JOIN dates AS dd ON gc.fk_conversation_start_date = dd.date_id

LEFT JOIN customers AS cd ON gc.fk_customer_id = c.customer_id

LEFT JOIN entities AS ed ON gc.new_country = ed.country

				
GROUP BY c.customer_id,
	,ed.country
	, gc.queue_name
	, dd.hellofresh_week
	, dd.iso_week
	, dd.date_string
	, dd.quarter
	, dd.year
	, gc.agent_email
	, gc.agent_department
	, gc.wrap_up_name
	, gc.wrap_up_note
	, gc.conversation_id
	, gc.media_type




-- 4
-- NAMING ERRORS


with customer_conversations_v2 as 
	( 
		SELECT DISTINCT conversation_id
			, agent_email
			, agent_department
			, wrap_up_name
			, wrap_up_note
			, media_type
			, queue_name
			, originating_direction
			, fk_conversation_start_date
			, fk_customer_id 
			, CASE 
				WHEN country IN ( 'GB', 'UK' ) THEN 'UK' ELSE country END AS 'new_country'

		FROM customer_conversations 

		WHERE country NOT IN ( 'EP', 'ER', 'GC' )
			and originating_direction = 'inbound'
			and participant_purpose = 'agent'

	)



SELECT DISTINCT cd.customer_id -- name was wrong
	, ed.country
	, gc.queue_name
	, dd.hellofresh_week
	, dd.iso_week
	, dd.date_string
	, dd.quarter
	, dd.year
	, gc.agent_email
	, gc.agent_department
	, gc.wrap_up_name
	, gc.wrap_up_note
	, gc.conversation_id
	, gc.media_type
	
	, CASE
		WHEN Lower(gc.wrap_up_note) LIKE '%virus%' OR Lower(gc.wrap_up_note) LIKE '%covid%' THEN 'Coronavirus'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Not paid'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'
	ELSE 'Other'
	END AS 'Keyword'

FROM customer_conversations_v2 AS gc

LEFT JOIN dates AS dd ON gc.fk_conversation_start_date = dd.date_id

LEFT JOIN customers AS cd ON gc.fk_customer_id = c.customer_id

LEFT JOIN entities AS ed ON gc.new_country = ed.country


GROUP BY c.customer_id,
	,ed.country
	, gc.queue_name
	, dd.hellofresh_week
	, dd.iso_week
	, dd.date_string
	, dd.quarter
	, dd.year
	, gc.agent_email
	, gc.agent_department
	, gc.wrap_up_name
	, gc.wrap_up_note
	, gc.conversation_id
	, gc.media_type


-- 5
-- Numbers in Group By
-- Easier to change
-- pREVENTS ERRORS ("wrong name")


with customer_conversations_v2 as 
	( 
		SELECT DISTINCT conversation_id
			, agent_email
			, agent_department
			, wrap_up_name
			, wrap_up_note
			, media_type
			, queue_name
			, originating_direction
			, fk_conversation_start_date
			, fk_customer_id 
			, country
			, CASE 
				WHEN country IN ( 'GB', 'UK' ) THEN 'UK' ELSE country END AS 'new_country'

		FROM customer_conversations 

		WHERE country NOT IN ( 'EP', 'ER', 'GC' )
			and originating_direction = 'inbound'
			and participant_purpose = 'agent'

	)



SELECT DISTINCT cd.customer_id -- name was wrong
	, ed.country
	, gc.queue_name
	, dd.hellofresh_week
	, dd.iso_week
	, dd.date_string
	, dd.quarter
	, dd.year
	, gc.agent_email
	, gc.agent_department
	, gc.wrap_up_name
	, gc.wrap_up_note
	, gc.conversation_id
	, gc.media_type
	
	, CASE
		WHEN Lower(gc.wrap_up_note) LIKE '%virus%' OR Lower(gc.wrap_up_note) LIKE '%covid%' THEN 'Coronavirus'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Not paid'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'
	ELSE 'Other'
	END AS 'Keyword'

FROM customer_conversations_v2 AS gc

LEFT JOIN dates AS dd ON gc.fk_conversation_start_date = dd.date_id

LEFT JOIN customers AS cd ON gc.fk_customer_id = c.customer_id

LEFT JOIN entities AS ed ON gc.new_country = ed.country


GROUP BY 1
	, 2
	, 3
	, 4
	, 5
	, 6
	, 7
	, 8
	, 9
	, 10
	, 11
	, 12
	, 13
	, 14




-- 6
-- Check the joins
-- Assume it's supposed to be left because we want to keep everything from the main table


with customer_conversations_v2 as 
	( 
		SELECT DISTINCT conversation_id
			, agent_email
			, agent_department
			, wrap_up_name
			, wrap_up_note
			, media_type
			, queue_name
			, originating_direction
			, fk_conversation_start_date
			, fk_customer_id 
			, CASE 
				WHEN country IN ( 'GB', 'UK' ) THEN 'UK' ELSE country END AS 'new_country'

		FROM customer_conversations 

		WHERE country NOT IN ( 'EP', 'ER', 'GC' )
			and originating_direction = 'inbound'
			and participant_purpose = 'agent'

	)



SELECT DISTINCT 
	cd.customer_id -- name was wrong
	
	, ed.country
	
	, gc.queue_name
	
	, dd.hellofresh_week
	, dd.iso_week
	, dd.date_string
	, dd.quarter
	, dd.year
	
	, gc.agent_email
	, gc.agent_department
	, gc.wrap_up_name
	, gc.wrap_up_note
	, gc.conversation_id
	, gc.media_type
	
	, CASE
		WHEN Lower(gc.wrap_up_note) LIKE '%virus%' OR Lower(gc.wrap_up_note) LIKE '%covid%' THEN 'Coronavirus'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Not paid'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
		WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'
	ELSE 'Other'
	END AS 'Keyword'

FROM customer_conversations_v2 AS gc

LEFT JOIN dates AS dd ON gc.fk_conversation_start_date = dd.date_id

-- customer and country so we need to join on the combination SO add country to main table ???)

LEFT JOIN customers AS cd ON gc.fk_customer_id = c.customer_id
							and gc.country = c.country

LEFT JOIN entities AS ed ON gc.new_country = ed.country


GROUP BY 1
	, 2
	, 3
	, 4
	, 5
	, 6
	, 7
	, 8
	, 9
	, 10
	, 11
	, 12
	, 13
	, 14
