Pod::Spec.new do |s|
  s.name         = 'FeedbackKit'
  s.version      = '0.1.0'
  s.summary      = 'FeedbackKit'
  s.description  = <<-DESC
                   FeedbackKit
                   DESC
  s.homepage     = 'https://github.com/FeedbackKit/FeedbackKit'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'jasonnam' => 'contact@jasonnam.com' }

  s.source       = { :path => '.' }
  s.source_files = 'Sources/FeedbackKit/**/*.{swift}'
end
