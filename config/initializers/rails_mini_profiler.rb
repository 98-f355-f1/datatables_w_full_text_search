# frozen_string_literal: true

# Rack::MiniProfiler.config.storage = Rack::MiniProfiler::MemoryStore
# Rack::MiniProfiler.config.snapshot_every_n_requests = 1
# Rack::MiniProfiler.config.authorization_mode = :allow_authorized

# Puma caught this error: fetch_snapshots is not implemented (NotImplementedError)
# /usr/share/rvm/gems/ruby-3.1.3/gems/rack-mini-profiler-2.3.4/lib/mini_profiler/storage/abstract_store.rb:53:in `fetch_snapshots'
# /usr/share/rvm/gems/ruby-3.1.3/gems/rack-mini-profiler-2.3.4/lib/mini_profiler/storage/abstract_store.rb:58:in `snapshot_groups_overview'
# /usr/share/rvm/gems/ruby-3.1.3/gems/rack-mini-profiler-2.3.4/lib/mini_profiler/profiler.rb:814:in `handle_snapshots_request'
# /usr/share/rvm/gems/ruby-3.1.3/gems/rack-mini-profiler-2.3.4/lib/mini_profiler/profiler.rb:184:in `serve_html'
# /usr/share/rvm/gems/ruby-3.1.3/gems/rack-mini-profiler-2.3.4/lib/mini_profiler/profiler.rb:254:in `call'
