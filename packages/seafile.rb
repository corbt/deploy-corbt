version     = "2.0.4"
archive     = "seafile-server_#{version}_x86-64.tar.gz"
folder      = "seafile-server-#{version}"
download    = "http://seafile.googlecode.com/files/#{archive}"
dir         = "/data/apps/seafile"

package :seafile do
        requires :extract_seafile, :seafile_essentials

        # Have to run this command, but can't do it from here bc non-interactive
        # runner "#{dir}/#{folder}/setup-seafile.sh"
end

package :extract_seafile do
        runner "mkdir -p #{dir}"
        runner "wget --directory-prefix=#{dir} #{download}"
        runner "cd #{dir} && tar -xzf #{archive}"
        runner "mkdir -p #{dir}/installed"
        runner "cd #{dir} && mv #{archive} installed/"

        verify { has_file "#{dir}/installed/#{archive}" }
end

package :seafile_essentials do 
        apt "python python-setuptools python-simplejson python-imaging sqlite3", sudo: true
end
