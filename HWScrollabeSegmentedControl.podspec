#
# Be sure to run `pod lib lint HWScrollabeSegmentedControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HWScrollabeSegmentedControl'
  s.version          = '0.0.1'
  s.summary          = 'A scrollable segment control'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
HWScrollableSegmentedControl is used to display a variety of segments, and it is scrollable when the some of the segments is out of the screen.
                       DESC

  s.homepage         = 'https://github.com/ihomway/HWScrollabeSegmentedControl'
  s.screenshots     = 'http://bit.ly/2oZsYF7', 'http://bit.ly/2ou6Scp', 'http://bit.ly/2opNPOO'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ihomway' => 'ihomway@live.com' }
  s.source           = { :git => 'https://github.com/ihomway/HWScrollabeSegmentedControl.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/ihomway'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HWScrollabeSegmentedControl/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HWScrollabeSegmentedControl' => ['HWScrollabeSegmentedControl/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
