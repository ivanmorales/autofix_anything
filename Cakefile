{spawn} = require 'child_process'
task 'watch', 'Build *.coffee files', ->
    spawn 'coffee', '-cbw *.coffee', customFds: [0..2]