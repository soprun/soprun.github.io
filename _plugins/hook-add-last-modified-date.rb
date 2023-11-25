Jekyll::Hooks.register :pages, :pre_render do |page|
  # debug
  # puts "Firing :docs, :pre_render from : " + File.basename(__FILE__) + " for : " + page.relative_path

  if File.exist?(page.path)
    # puts "File not exist from : " + File.basename(__FILE__) + " for : " + page.relative_path
    # get the current post last modified time
    modification_time = File.mtime(page.path)

    # debug
    # puts "modification_time = " + modification_time.strftime('%A, %B %dth %Y at %l:%M%p')

    # inject modification_time in post's datas.
    page.data['last-modified-date'] = modification_time
  end
end

Jekyll::Hooks.register :posts, :pre_render do |post|
  if File.exist?(post.path)
    # get the current post last modified time
    modification_time = File.mtime(post.path)

    # inject modification_time in post's datas.
    post.data['last-modified-date'] = modification_time
  end
end
