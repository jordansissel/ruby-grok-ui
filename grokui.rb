#!/usr/bin/env ruby

require "rubygems"
require "sinatra"
require "grok-pure"

__DIR__ = File.dirname(__FILE__)
PUBLIC_DIR = File.join(__DIR__, "public")
PATTERNS_DIR = File.join(__DIR__, "patterns")
set :public_folder, PUBLIC_DIR

get "/" do
  content_type "text/html"
  send_file File.join(PUBLIC_DIR, "index.html")
end

post "/api/grok" do
  content_type "application/json"

  text = params[:text]

  grok = Grok.new
  Dir.glob("#{PATTERNS_DIR}/*").each { |p| grok.add_patterns_from_file(p) }

  pattern = grok.discover(text)
  grok.compile(pattern)

  m = grok.match(text)
  data = {}
  if m
    data["captures"] = m.captures
    data["pattern"] = pattern
    data["expanded_pattern"] = grok.expanded_pattern
    data["status"] = "success"
  else
    data["status"] = "failure"
    data["pattern"] = pattern
  end

  body data.to_json
end
