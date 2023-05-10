# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

# POSSIBLE EXAMPLE TO INCLUDE VIEW COMPONENTS IN MINI-PROFILER
# require 'rack-mini-profiler'
# Rack::MiniProfiler.profile_method(Hanami::View::Rendering::Partial, :render) { "Render partial #{@options[:partial]}" }

# use Rack::MiniProfiler

run Rails.application
Rails.application.load_server
