
, CASE

	-- assumption is that corona only does not appear (if corona always coronavirus)
	WHEN Lower(gc.wrap_up_note) LIKE '%virus%' OR Lower(gc.wrap_up_note) LIKE '%covid%' THEN 'Coronavirus'
		
	-- 'Refund not received'
	WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Refund' AND Lower(gc.wrap_up_note) LIKE '%not received%' THEN 'Refund not received'
		
	-- 'Not paid'
	WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%not paid%' THEN 'Not paid'
	
	-- 'Paid'
	WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Reactivation' AND Lower(gc.wrap_up_note) LIKE '%paid%' THEN 'Not paid'

	-- Payment plan
	WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%payment plan%' THEN 'Payment plan'
		
	-- 'Manual payment'
	WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Outstanding' AND Lower(gc.wrap_up_note) LIKE '%manual%' THEN 'Manual payment'

	-- 'Overview'
	WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND gc.wrap_up_name = 'Payments - Other' AND Lower(gc.wrap_up_note) LIKE '%overview%' THEN 'Overview'

	-- Email
	WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%mail%' THEN 'Email'
	
	-- GDPR
	WHEN ed.country_group IN ('AU','NZ','BENELUXFR','UK') AND Lower(gc.wrap_up_note) LIKE '%gdpr%' THEN 'GDPR'


	ELSE 'Other'
	END AS 'Keyword'
