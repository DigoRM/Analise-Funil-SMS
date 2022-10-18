use sistema;

SELECT
u.name as produtor,
c.name empresa,
si.name site,
usq.name as squad,
count(distinct si.id) as lojas_criadas,
sum(t.orders_approved_amount) as "pedidos_aprovados",
sum(t.orders_approved) as total_aprovado,
sum(orders_partner_total) as total_parceiro,
sum(orders_pix_approved),
sum(t.orders_pix_amount),
sum(orders_pix_approved_amount)
,sms.funnel_id,
sms.config_id,
sms.message,
sms.created_at,
sms.deleted_at,
sms_events.name as evento,
sms_events.created_at as evento_criado,
sms_events.deleted_at as evento_deletado,
count(distinct sent.id) as mensagens_enviadas


from tax t
left JOIN site si ON si.id = t.site_id	
left JOIN company c ON c.id = si.company_id
left JOIN users u ON u.id = c.user_id
left join user_squads usq on usq.id = u.squad_id
inner join sms_bot_templates sms on sms.user_id = u.id
inner join sms_bot_events sms_events on sms_events.id = sms.event_id
left join site_integrations sion on sion.site_id=si.id
left join sms_messages_sent sent on sent.sms_bot_template_id = sms.id


#where sms.deleted_at is null
where sms_events.name like "%pix%"
AND c.id not in (1,2,3,4,112,474, 1505,550, 683,997,1506,1703,1703,290,290,1551,1551,290,290,685,290,544,1551,1907,290,290,544,2815,290,544,544,1551,290,1551,290,5751,1508,2815)
#and u.name like "%Diego Fernandes Spenciere%"
and t.date between '2022-09-15 00:00:00' and '2022-10-15 23:59:59'    #curdate() - interval 1 month and curdate()

group by u.id