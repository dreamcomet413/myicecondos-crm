class Activity

  def self.get_activities lead
    activities = ActiveRecord::Base.connection.execute("select * from #{APP_CONFIG[:icecondos_db]}.ahoy_events where user_id in (select id from #{APP_CONFIG[:icecondos_db]}.users where email = '#{lead.email}') and name IN ('Viewed listing', 'Searched', 'Searched Location', 'Advanced Search') order by time desc;")
  end

  def self.get_listings_viewed lead
    activities = ActiveRecord::Base.connection.execute("select * from #{APP_CONFIG[:icecondos_db]}.ahoy_events where user_id in (select id from #{APP_CONFIG[:icecondos_db]}.users where email = '#{lead.email}') and name = 'Viewed listing' order by time desc")
  end

  def self.most_active_leads
    users = ActiveRecord::Base.connection.execute("select u.email, v.user_id, count(v.id) as num from #{APP_CONFIG[:icecondos_db]}.users u left join #{APP_CONFIG[:icecondos_db]}.visits v on u.id = v.user_id where v.user_id IS NOT NULL group by v.user_id order by num DESC limit 20;")
    emails = users.collect{|u| u[0]}
    Contact.where(email: emails)
  end
end
