require 'frank-cucumber'

# UIQuery is deprecated. Please use the shelley selector engine.
Frank::Cucumber::FrankHelper.use_shelley_from_now_on

# This constant must be set to the full, absolute path for your Frankified target's app bundle.
# See the "Given I launch the app" step definition in launch_steps.rb for more details
APP_BUNDLE_PATH = File.expand_path( '../../../frankified_build/lintu frankified.app', __FILE__ )
fake_backend_pid = nil

Before do
  FileUtils.rm_rf(File.dirname(__FILE__) + '/../fixtures/*')
  FileUtils.rm_rf(File.dirname(__FILE__) + '/last_requests.log')

  fake_backend_pid = fork do
    exec "cd #{File.dirname(__FILE__)} && rackup -p 9092 2>&1 1>/dev/null"
  end

  sleep 3

  Process.detach(fake_backend_pid)
end

After do
  Process.kill("KILL", fake_backend_pid)
  Process.kill("KILL", fake_backend_pid + 1)
end