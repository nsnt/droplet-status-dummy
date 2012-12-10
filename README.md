droplet-status-dummy
====================

INSTALL
-------

* bundle install --path vendor/bundle

RUN
---

1. (optional) bundle exec nats-server -d -p PORT

    PORT may be an arbitrary number that does not preoccupied.

2. bundle exec ./dummy_droplet_status.rb nats://HOST:PORT &

    If you use the server started in the previous item, HOST may be '127.0.0.1' and PORT should be same as the number specified.

3. (optional) bundle exec nats-request "process_droplet_status" "" -n 1 -s nats://HOST:PORT

    If you use the server started in the previous item, HOST may be '127.0.0.1' and PORT should be same as the number specified.
