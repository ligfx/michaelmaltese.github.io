def datetime_from_filename(data)
	if data.date
		raise Exception, "Date will be inferred from filename, but found in data"
	end
	if data.datetime
            raise Exception, "Datetime will be inferred from filename, but found in data"
    end

    regex = /^(\d{4}-\d{1,2}-\d{1,2})(T(\d{2}):?(\d{2}))?/
    if File.basename(data._fname) =~ regex
    		data.date = Time.parse($1)
    		hours = $3.to_i
    		minutes = $4.to_i
    		data.datetime = data.date  + hours * 360 + minutes * 60
    else
            raise Exception, "Expected filename to start with date and possibly time (#{regex.inspect})"
    end

    data
end

Edison.config do
	models.posts.each do |post|
		datetime_from_filename(post)

		# post.url = "posts/#{post._fname}/index.html"
		# routes.url post.url, "post", post
		post.is_post = true
	end

	models.links.each do |link|
		datetime_from_filename(link)
		link.is_link = true
	end

	objects = (models.posts + models.links).sort_by(&:datetime).reverse

	routes.url "archive.html" do |data|
		data.objects = objects.map do |o|
			o = o.clone
			o.date = o.date.strftime("%B %d, %Y")
			o
		end
	end

	routes.url "blog.html" do |data|
		data.objects_by_day = objects.group_by(&:date).
		to_a.
		sort_by { |date, _| date }.
		reverse.
		map do |(date, os)|
			date = date.strftime("%A, %d %B %Y")
			os = os.sort_by(&:datetime).reverse
			{:date => date,
			 :objects => os}
		end
	end
end
