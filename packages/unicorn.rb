package :unicorn, provides: :appserver do 
	requires :nginx, :fs

  file "/etc/nginx/sites-available/corbt_nginx.conf", contents: render('corbt_nginx.conf'), sudo: true

	# transfer "templates/corbt_nginx", "/etc/nginx/sites-available", sudo: true
	runner "ln -s /etc/nginx/sites-available/corbt_nginx.conf /etc/nginx/sites-enabled", sudo: true
	runner "rm -f /etc/nginx/sites-enabled/default", sudo: true
	runner "service nginx restart", sudo: true

	verify{ has_symlink "/etc/nginx/sites-enabled/corbt_nginx.conf","/etc/nginx/sites-available/corbt_nginx.conf" }
end

