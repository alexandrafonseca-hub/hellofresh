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

SELECT DISTINCT cd.customer_id 
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

