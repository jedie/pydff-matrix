# Explore matrix Synapse 

Python Meeting Düsseldorf
Virtual Spring Sprint 2020


## quickstart

Create `.env` file, e.g.:

    SYNAPSE_SERVER_NAME=my.matrix.host
    SYNAPSE_REPORT_STATS=no
    
Add this to `.env` for `nio` client tests:

    ADMIN_USER_NAME=<username>
    ADMIN_USER_PASSWORD=<password>
  
  
install poetry:

    make install-poetry
    
create virtualenv via poetry:
    
    make install
    
Create config file from environment variables:
    
    make generate-config
    
Edit the generated config file: `./homeserver.yaml` and activate `listeners` ports:

* `8008` used for unsecure HTTP without TLS
* `8448` used for secure HTTP with TLS

Note: You have to configure your router/firewall to forward these ports:

| external (internet) | internal |
|-------|--------|
| `80`  | `8008` |
| `448` | `8448` |

Request Let's Encrypt certificates via certbot:

    make certbot

Generated certificates are stored here:

    ./live/${SYNAPSE_SERVER_NAME}/
    
Change in `./homeserver.yaml` this:
    
    tls_certificate_path: "/full/path/to/pydff-matrix/live/${SYNAPSE_SERVER_NAME}/fullchain.pem"
    tls_private_key_path: "/full/path/to/pydff-matrix/live/${SYNAPSE_SERVER_NAME}/privkey.pem"
    
start matrix server:
    
    make start-server
    
create a admin user:
    
    make register-new-matrix-user
    

Just all `make` to see all existing commands, e.g.:

    $ make
    help                      List all commands
    install-poetry            install or update poetry
    install                   install python-poetry_publish via poetry
    generate-config           generate config from template "homesserver.yaml"
    start-server              start synapse server
    register-new-matrix-user  register a new user
    certbot                   request Let's encrypt certificates

## links

* https://upcloud.com/community/tutorials/install-matrix-synapse/