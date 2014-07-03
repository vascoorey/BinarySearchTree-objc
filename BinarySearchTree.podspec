Pod::Spec.new do |s|
  s.name         = "BinarySearchTree"
  s.version      = "0.0.1"
  s.summary      = "An Objective-c implementation of a Binary Search Tree (BST)"
  s.description  = <<-DESC
                   Implemented from Algorithms, 4th Edition
                   To be used in an Objective-c implementation of the Java metazelda dungeon generator.
                   DESC
  s.homepage     = "https://github.com/vascoorey/BinarySearchTree-objc"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = "Vasco d'Orey"
  s.social_media_url   = "http://twitter.com/oppfiz"
  s.requires_arc = true
  s.source       = { :git => "https://github.com/vascoorey/BinarySearchTree-objc.git", :tag => "0.0.1" }
  s.source_files  = "BinarySearchTree/Source", "BinarySearchTree/Source/**/*.{h,m}"
end
