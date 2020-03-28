# Explore matrix Synapse 

Python Meeting Düsseldorf
Virtual Spring Sprint 2020


## quickstart

Create `.env` file, e.g.:

    SYNAPSE_SERVER_NAME=my.matrix.host
    SYNAPSE_REPORT_STATS=no
    
call this:

    make install-poetry
    make install
    make generate-config
    make start-server
    make register-new-matrix-user
    

Just all `make` to see all existing commands, e.g.:

    $ make
    help                      List all commands
    install-poetry            install or update poetry
    install                   install python-poetry_publish via poetry
    generate-config           generate config from template "homesserver.yaml"
    start-server              start synapse server
    register-new-matrix-user  register a new user


## links

* https://upcloud.com/community/tutorials/install-matrix-synapse/