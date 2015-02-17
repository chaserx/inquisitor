include_recipe 'inquisitor::default'

package 'postgresql'
package 'libpq-dev'

execute 'gem install foreman'

# capture error ouput
# swallow errors if they are because the user exists
# all other errors make the grep also fail
file '/tmp/createuser.err' do
  action :delete
end
execute 'sudo -u postgres createuser --superuser vagrant ' +
        '2>/tmp/createuser.err ' +
        '|| grep exists /tmp/createuser.err'

execute 'bin/bundle' do
  user 'vagrant'
  environment 'HOME' => '/home/vagrant'
  cwd '/home/vagrant/inquisitor'
end

execute 'bin/rake db:reset' do
  user 'vagrant'
  environment 'HOME' => '/home/vagrant'
  cwd '/home/vagrant/inquisitor'
  only_if { File.file?('/home/vagrant/inquisitor/db/schema.rb') }
end

execute 'bower install --save' do
  user 'vagrant'
  environment 'HOME' => '/home/vagrant'
  cwd '/home/vagrant/inquisitor'
end
