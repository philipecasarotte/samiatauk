Factory.define :page do |p|
  p.name 'Home'
  p.body 'Coming Soon'
  p.permalink 'home'
  p.is_protected 0
end

Factory.define :about, :parent => :page do |p|
  p.name 'About Us'
  p.body 'About us'
  p.permalink 'about-us'
  p.is_protected 0
end

Factory.define :about_child, :parent => :page do |f|
  f.parent { |parent| parent.association(:about)  }
end

Factory.define :long_page, :parent => :page do |f|
  f.body "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin sed lectus ac sapien consectetur dapibus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed hendrerit elit. Aliquam velit felis, imperdiet eu, egestas sed, consequat et, ligula. Nullam bibendum dictum metus. Maecenas ut tellus non nulla dapibus tincidunt. Curabitur ullamcorper, arcu sed feugiat elementum, ligula libero accumsan velit, bibendum pulvinar enim est at magna. Suspendisse et neque quis leo lobortis dictum. Aliquam justo mauris, ornare ac, mollis vitae, convallis vitae, metus. Nunc commodo sapien et mauris. Aliquam vitae ligula. Proin mi turpis, dignissim sed, mattis quis, dignissim sagittis, diam. Nullam a neque. Maecenas ornare vulputate metus. Suspendisse potenti. Vestibulum mattis arcu et quam."
end
