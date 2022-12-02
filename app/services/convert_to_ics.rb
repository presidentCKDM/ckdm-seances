class ConvertToIcs

	attr_reader :invitations

	def self.call(*args)
		new(*args).call
	end

	def initialize(invitations)
		@invitations = invitations
	end

	def call
		perform_conversion
	end

	private
		def perform_conversion
			calendar = Icalendar::Calendar.new

			invitations.each do |invitation|
				calendar.add_event convert(invitation)
			end

			calendar.publish

			calendar
		end

		def convert(invitation)
			Icalendar::Event.new.tap do |event|
				start_date 	= invitation.training_session.started_at
				end_date 		= start_date + 2.hours

				training_session = invitation.training_session

	  		event.dtstart = start_date.strftime("%Y%m%dT%H%M%S")
	  		event.dtend = end_date.strftime("%Y%m%dT%H%M%S")
	  		event.summary = "Entrainement Polo - #{training_session.location.name}"
	  		event.description = training_session.groups.map(&:name).join(", ")
	  		event.location = training_session.location.name
	  		event.ip_class = "PUBLIC"
	  		event.created = training_session.created_at
	  		event.last_modified = training_session.updated_at
	  		event.uid = "#{invitation.user.token}_#{invitation.id}"
	  		event.url = "http://polo.ckdm.fr"

  		end
		end
end