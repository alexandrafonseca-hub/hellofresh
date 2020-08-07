

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
		WHEN Lower(gc.wrap_up_note) LIKE '%virus%' THEN 'Coronavirus'
		
		WHEN Lower(gc.wrap_up_note) LIKE '%coronavirus%' THEN'Coronavirus'
		
		WHEN Lower(gc.wrap_up_note) LIKE '% covid%' THEN 'Coronavirus' 
		
		WHEN ed.country_group = 'BENELUXFR' AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'
		
		WHEN ed.country_group = 'BENELUXFR' AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
		
		WHEN ed.country_group = 'BENELUXFR' AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Paid'
		
		WHEN ed.country_group = 'BENELUXFR' AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'
		
		WHEN ed.country_group = 'BENELUXFR' AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'
		
		WHEN ed.country_group = 'BENELUXFR' AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'
		
		WHEN ed.country_group = 'BENELUXFR' AND Lower(gc.wrap_up_note) LIKE '%email%' THEN 'Email'
		
		WHEN ed.country_group = 'BENELUXFR' AND Lower(gc.wrap_up_note) LIKE '%e-mail%' THEN 'Email'
		
		WHEN ed.country_group = 'BENELUXFR' AND Lower(gc.wrap_up_note) LIKE '%e mail%' THEN 'Email'
		
		WHEN ed.country_group = 'BENELUXFR' AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
		
		WHEN ed.country_group = 'BENELUXFR' AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'

		WHEN ed.country_group IN ( 'AU', 'NZ' ) AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'
		
		WHEN ed.country_group IN ( 'AU', 'NZ' ) AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
		
		WHEN ed.country_group IN ( 'AU', 'NZ' ) AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Paid'

		WHEN ed.country_group IN ( 'AU', 'NZ' ) AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'
		
		WHEN ed.country_group IN ( 'AU', 'NZ' ) AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'

		WHEN ed.country_group IN ( 'AU', 'NZ' ) AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'

		WHEN ed.country_group IN ( 'AU', 'NZ' ) AND Lower(gc.wrap_up_note) LIKE '%email%' THEN 'Email'
		
		WHEN ed.country_group IN ( 'AU', 'NZ' ) AND Lower(gc.wrap_up_note) LIKE '%e-mail%' THEN 'Email'

		WHEN ed.country_group IN ( 'AU', 'NZ' ) AND Lower(gc.wrap_up_note) LIKE '%e mail%' THEN 'Email'

		WHEN ed.country_group IN ( 'AU', 'NZ' ) AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'

		WHEN ed.country_group IN ( 'AU', 'NZ' ) AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'

		WHEN ed.country_group = 'UK' AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'

		WHEN ed.country_group = 'UK' AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'

		WHEN ed.country_group = 'UK' AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Paid'

		WHEN ed.country_group = 'UK' AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan

		WHEN ed.country_group = 'UK' AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment' 

		WHEN ed.country_group = 'UK' AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'

		WHEN ed.country_group = 'UK' AND Lower(gc.wrap_up_note) LIKE '%email%' THEN 'Email'

		WHEN ed.country_group = 'UK' AND Lower(gc.wrap_up_note) LIKE '%e-mail%' THEN 'Email'
		
		WHEN ed.country_group = 'UK' AND Lower(gc.wrap_up_note) LIKE '%e mail%' THEN 'Email'

		WHEN ed.country_group = 'UK' AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'

		WHEN ed.country_group = 'UK' AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'
		
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
	)ASnc
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





















