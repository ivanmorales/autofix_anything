{exec} = require 'child_process'
task 'watch', 'Build *.coffee files', ->
    exec 'coffee -cbw *.coffee', (err, stdout, stderr)->
        throw err if err
        console.log stdout + stderr
