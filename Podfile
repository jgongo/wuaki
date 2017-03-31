# Wuaki test iOS client

# Reskit/Testing is not included in the :test target because doing so causes some
# nasty problems regarding duplicate symbols in libPods and libPods-test. This is the
# recommended configuration according to Blake Watters (creator of RestKit):
#   https://groups.google.com/forum/?fromgroups=#!topic/restkit/DrFGMwmJN-s

platform :ios, '10.0'
inhibit_all_warnings!

target 'wuaki' do
  project 'wuaki/wuaki.xcodeproj'

  # Networking
  pod 'RestKit/Core',    '0.27.0'
  pod 'RestKit/Testing', '0.27.0'

  # Infrastructure
  pod 'Typhoon',         '3.5.1'

  # Debugging / testing
  pod 'CocoaLumberjack', '2.4.0'
  pod 'XCDLumberjackNSLogger', '1.1.0'

  # UI
  pod 'RMessage',        '2.1.0'
  pod 'SDWebImage',      '3.8.2'

  target 'wuakiTests' do
    pod 'Kiwi',           '2.0.6'
    pod 'RKKiwiMatchers', '0.20.0'
    pod 'OHHTTPStubs',    '5.2.1'
  end
end
