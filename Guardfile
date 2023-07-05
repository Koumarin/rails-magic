guard :minitest, spring: 'bin/rails test', all_on_start: false do
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^test/test_helper\.rb$})                      {'test'}
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})                      {|m| "test/#{m[1]}test_#{m[2]}.rb"}
  watch(%r{^lib/(.+)\.rb$})                               {|m| "test/lib/#{m[1]}_test.rb"}
  watch(%r{^app/(.+)\.rb$})                               {|m| "test/#{m[1]}_test.rb"}
  watch(%r{^app/controllers/application_controller\.rb$}) {'test/controllers'}
  watch(%r{^app/controllers/(.+)_controller\.rb$})        {|m| "test/integration/#{m[1]}_test.rb"}
  watch(%r{^app/views/(.+)_mailer/.+})                    {|m| "test/mailers/#{m[1]}_mailer_test.rb"}
  watch('config/routes.rb')                               {interface_tests}
end

def interface_tests
  integration_tests << 'tests/controllers/'
end
