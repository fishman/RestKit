Pod::Spec.new do |s|
  s.name         =  'RestKit'
  s.version      =  '0.9.4'
  s.summary      =  'RestKit is a framework for consuming and modeling RESTful web resources on iOS and OS X.'
  s.homepage     =  'http://www.restkit.org'
  s.author       =  { 'Blake Watters' => 'blakewatters@gmail.com' }
  s.source       =  { :git => 'https://github.com/fishman/RestKit.git', :branch => '0.9.4' }
  s.license      =  'Apache License, Version 2.0'

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.6'

  ### Preferred dependencies

  s.default_subspec = 'JSON'

  s.prefix_header_contents = <<-EOS
#ifdef COCOAPODS_POD_AVAILABLE_RestKit_CoreData
    #import <CoreData/CoreData.h>
#endif
EOS

  # Preserve the layout of headers in the Code directory
  s.header_mappings_dir = 'Code'

  s.subspec 'JSON' do |js|
    js.dependency 'RestKit/ObjectMapping'
    js.dependency 'RestKit/Network'
    js.dependency 'RestKit/ObjectMapping/JSON'
    js.dependency 'RestKit/CoreData'
  end

  s.subspec 'XML' do |xs|
    xs.dependency 'RestKit/ObjectMapping'
    xs.dependency 'RestKit/Network'
    xs.dependency 'RestKit/ObjectMapping/XML'
    xs.dependency 'RestKit/CoreData'
  end

  ### Subspecs

  s.subspec 'Network' do |ns|
    ns.source_files   = 'Code/Network'
    ns.ios.frameworks = 'CFNetwork', 'Security', 'MobileCoreServices', 'SystemConfiguration'
    ns.osx.frameworks = 'CoreServices', 'Security', 'SystemConfiguration'
    ns.dependency       'RestKit/ObjectMapping'
    ns.dependency       'RestKit/Support'
    # ns.dependency       'LibComponentLogging-NSLog', '>= 1.0.4'
    # ns.dependency       'FileMD5Hash'
    # ns.dependency       'SOCKit'

    ns.prefix_header_contents = <<-EOS
#import <Availability.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED
  #import <SystemConfiguration/SystemConfiguration.h>
  #import <MobileCoreServices/MobileCoreServices.h>
  #import <Security/Security.h>
#else
  #import <SystemConfiguration/SystemConfiguration.h>
  #import <CoreServices/CoreServices.h>
  #import <Security/Security.h>
#endif
EOS
  end

  s.subspec 'ObjectMapping' do |os|
    os.source_files = 'Code/ObjectMapping'
    os.dependency     'RestKit/Support'
    os.dependency     'RestKit/Network'

    os.subspec 'JSON' do |jos|
      jos.source_files = 'Code/Support/Parsers/JSON/RKJSONParserJSONKit.{h,m}'
      jos.dependency     'JSONKit', '>= 1.5pre'
    end

    os.subspec 'XML' do |xos|
      xos.source_files = 'Code/Support/Parsers/XML/RKXMLParserXMLReader.{h,m}'
      xos.libraries    = 'xml2'
      xos.dependency     'XMLReader'
    end

  end

  s.subspec 'CoreData' do |cdos|
    cdos.source_files = 'Code/CoreData'
    cdos.frameworks   = 'CoreData'
  end

  s.subspec 'Support' do |ss|
    ss.source_files   = 'Code/RestKit.h', 'Code/Support', 'Vendor/LibComponentLogging/Core', 'Vendor/LibComponentLogging/NSLog'
    ss.exclude_files  = 'Code/Support/Parsers/**/*'
  end

end
