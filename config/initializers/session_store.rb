require 'action_dispatch/middleware/session/dalli_store'
Ccc360::Application.config.session_store :dalli_store, :memcache_server => ['127.0.0.1'], :namespace => 'sessions', :key => '_sp2_session', :expire_after => 2.days
