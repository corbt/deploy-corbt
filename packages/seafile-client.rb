package :seafile_client do 
  requires :sf_client_install, :sf_client_sync
end

password = ""
STDIN.noecho do
  print "Seafile user password: "
  password = gets.chomp
end

package :sf_client_install do
  version = "2.0.6"
  url = "http://seafile.googlecode.com/files/seafile-cli_#{version}_x86-64.tar.gz"

  runner "mkdir -p /etc/seafile", sudo: true
  runner "mkdir -p /data/apps/seafile/client"	

  runner "wget #{url} -P /tmp", sudo: true
  runner "tar xzf /tmp/seafile-cli_#{version}_x86-64.tar.gz -C /etc/seafile", sudo: true
  runner "/etc/seafile/seafile-cli-2.0.6/seaf-cli init -d /data/apps/seafile/client"
  runner "/etc/seafile/seafile-cli-2.0.6/seaf-cli start"

  runner "ln -s `readlink -f /etc/seafile/seafile-cli-2.0.6/seaf-cli` /usr/bin/", sudo: true

  verify { has_executable "seaf-cli" }
end

package :sf_client_sync do
  requires :sf_client_install

  runner "seaf-cli download -l 2382ea44-d997-4c5a-9da3-39414dd7d381 -s http://corbt.com:8000 -d . -u kylecorbitt@gmail.com -p #{password}"

  verify { has_directory "/data/apps/web" }
end