atom_feed do |feed|
	feed.title("Sâmia Tauk | Meu Blog")
	feed.updated(@posts.first.published_on)
	
	@posts.each do |post|
		feed.entry(post) do |entry|
			entry.title(post.name)
			entry.content(post.body, :type=>"html")
			entry.author{|author| author.name{"Sâmia Tauk | Meu Blog"}}
		end
	end
end