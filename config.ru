# This file is used by Rack-based servers to start the application.

# 新版require够简洁的了
require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application
