Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '474212325967773', '94e7330dead9aaa0e486608321b72151'
  provider :twitter, 'uw7veWFRrtYXjH8wZF7CJg', '8eSIEZnmNSCuiDP3qX2ZbXrVWRFzG1LRIeP7vImag'
end