Pod::Spec.new do |s|
  s.name         =  'RestKit'
  s.version      =  '0.9.4'
  s.summary      =  'RestKit is a framework for consuming and modeling RESTful web resources on iOS and OS X.'
  s.homepage     =  'http://www.restkit.org'
  s.author       =  { 'Blake Watters' => 'blakewatters@gmail.com' }
  s.source       =  { :git => 'https://github.com/fishman/RestKit.git', :branch => '0.9.4' }
  s.license      =  'Apache License, Version 2.0'

  # Preserve the layout of headers in the Code directory
  s.header_mappings_dir = 'Code'

  ### Preferred dependencies

  s.default_subspec = 'JSON'

  s.subspec 'JSON' do |js|
    js.dependency 'RestKit/Network'
    js.dependency 'RestKit/ObjectMapping'
    js.dependency 'RestKit/ObjectMapping/JSON'
    js.dependency 'RestKit/ObjectMapping/CoreData'
  end

  s.subspec 'XML' do |xs|
    xs.dependency 'RestKit/Network'
    xs.dependency 'RestKit/ObjectMapping'
    xs.dependency 'RestKit/ObjectMapping/XML'
    xs.dependency 'RestKit/ObjectMapping/CoreData'
  end

  ### Subspecs

  s.subspec 'Network' do |ns|
    ns.source_files   = 'Code/Network'
    ns.dependency     = 'RestKit/Support'
    ns.ios.frameworks = 'CFNetwork', 'Security', 'MobileCoreServices', 'SystemConfiguration'
    ns.osx.frameworks = 'CoreServices', 'Security', 'SystemConfiguration'
    # ns.dependency       'LibComponentLogging-NSLog', '>= 1.0.4'
    # ns.dependency       'FileMD5Hash'
    # ns.dependency       'SOCKit'
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

    os.subspec 'CoreData' do |cdos|
      cdos.source_files = 'Code/CoreData'
      cdos.frameworks   = 'CoreData'
    end
  end

  s.subspec 'Support' do |ss|
    ss.source_files   = 'Code/RestKit.h', 'Code/Support.h', 'Code/Support', 'Vendor/LibComponentLogging/Core', 'Vendor/LibComponentLogging/NSLog'
    ss.exclude_files  = 'Code/Support/Parsers/**/*'
  end

end
