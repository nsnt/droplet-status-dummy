#!/usr/bin/env ruby

require 'nats/client'

nats_uri = ARGV[0] || "nats://127.0.0.1:4222"
start_time = Time.now

EM.error_handler do |err|
  STDERR.puts "Eventmachine problem, #{err}"
end

EM.run do

  NATS.on_error do |err|
    STDERR.puts("EXITING! NATS error: #{err}")
    exit!
  end

  NATS.start(:uri => nats_uri) do
    NATS.subscribe('droplet.status') { |msg, reply| process_droplet_status(msg, reply, start_time) }
  end

  def process_droplet_status(msg, reply, start_time)
    now = Time.now
    response = {
      :name => "dummy-droplet",
      :users => ["dummy-user"],
      :droplet_id => 0,
      :instance_id => "00000000000000000000000000000000",
      :instance_index => 0,
      :pid => 0,
      :host => "0.0.0.0",
      :port => 0,
      :uris => ["dummy.example.org", "dummy2.example.org"], 
      :uptime => now - start_time,
      :mem_quota => 0,
      :disk_quota => 0,
      :fds_quota => 0,
      :usage => {
        :time => now,
        :cpu => 0,
        :mem => 0,
        :disk => 0
      }
    }
    NATS.publish(reply, response.to_json)
  end
end
