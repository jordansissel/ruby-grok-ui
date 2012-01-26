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

  input = params[:input]
  pattern = params[:pattern]

  grok = Grok.new
  Dir.glob("#{PATTERNS_DIR}/*").each { |p| grok.add_patterns_from_file(p) }

  grok.compile(pattern)
  m = grok.match(input)

  response = { }
  if m
    response["captures"] = m.captures
    response["status"] = "success"
  else
    response["status"] = "failure"
  end

  body response.to_json
end
