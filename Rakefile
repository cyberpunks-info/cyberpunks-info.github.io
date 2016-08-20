# Load all files in _rake
Dir["_rake/*.rb"].each {|file| load file}

desc "Serve the site through jekyll"
task :serve do; sh "bundle exec jekyll serve"; end

desc "Build the site through jekyll"
task :build do; sh "bundle exec jekyll build"; end

desc "Clean up the site"
task :clean do
  sh "bundle exec jekyll clean"
  [".sass-cache", "mkmf.log"].each do |file|
    sh "rm -r #{file}" if File.file? file
  end
end

desc "Output and optimize the site favicon"
task :favicon do
  output = "img/favicon.png"

  # Export the image at the default 64x resolution and optimize
  Images.inkscape "_resources/favicon.svg", output
  Images.optimize output
end

task :compressor do
  download_compressor
end
