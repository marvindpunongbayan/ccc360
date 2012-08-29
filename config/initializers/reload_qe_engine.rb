if Rails.env == "development"
  lib_reloader = ActiveSupport::FileUpdateChecker.new(Dir["vendor/ruby/1.9.1/bundler/gems/**/*.rb"]) do
    Rails.application.reload_routes! # or do something better here
  end

  ActionDispatch::Callbacks.to_prepare do
    lib_reloader.execute_if_updated
  end
end