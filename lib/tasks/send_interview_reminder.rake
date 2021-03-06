require "active_support/core_ext/numeric/time"

# Offset of 4hrs due to EST for 12-36 hour time window.

namespace :cron do
  desc "Send email reminder if interview for a given user is happening in the next 12-36 hours."
  task :send_interview_reminder => :environment do

		Interview.all.each do |interview|
			date_time = interview.merge_datetime_object
			
			if ( (date_time > (Time.now + 8.hours)) && (date_time <= (Time.now + 32.hours)) )
				UserMailer.interview_reminder(interview).deliver
			end

		end
	end

end