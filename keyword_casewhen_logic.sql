, CASE
		-- assumption is that corona only does not appear (if corona always coronavirus)
		WHEN Lower(gc.wrap_up_note) LIKE '%virus%' OR Lower(gc.wrap_up_note) LIKE '%covid%' THEN 'Coronavirus'

		--WHEN Lower(gc.wrap_up_note) LIKE '%virus%' THEN 'Coronavirus'
		--WHEN Lower(gc.wrap_up_note) LIKE '%coronavirus%' THEN 'Coronavirus'
		--WHEN Lower(gc.wrap_up_note) LIKE '% covid%' THEN 'Coronavirus' 
		
		-- There are more countries outside of the US AND ('AU','NZ','BENELUXFR','UK') otherwise, we would exclude the country from the key words
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
