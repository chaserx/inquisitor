package 'software-properties-common'
execute 'add-apt-repository --yes ppa:brightbox/ruby-ng'
execute 'apt-get update'

include_recipe 'annoyances'
# node.set['build-essential']['compile_time'] = true
include_recipe 'build-essential'

package 'postgresql-client'

package 'ruby2.2'
package 'ruby2.2-dev'
package 'libruby2.2'

package 'nodejs'

execute 'gem install bundler'
execute 'gem install unicorn'
