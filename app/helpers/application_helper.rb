module ApplicationHelper

	def full_title(page_title)
		base_title = "Free Forum"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def fake_post
		content = "#{Faker::Lorem.paragraph(rand(1..20))}"

		5.times do
			if rand(2) == 0
				content += "\n\n #{Faker::Lorem.paragraph(rand(1..20))}"
			end
		end

		return content
	end
	
end
