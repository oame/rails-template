Rails.application.config.generators do |g|
  g.test_framework :rspec, fixture: true, view_specs: false
end
