# Defined in - @ line 1
function cucumber_step --wraps='CAPYBARA_STEP=1 bundle exec cucumber' --description 'alias cucumber_step=CAPYBARA_STEP=1 bundle exec cucumber'
  CAPYBARA_STEP=1 bundle exec cucumber $argv;
end
