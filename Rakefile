task :serve do
  system "bundle exec jekyll serve"
end

task :build do
  system "bundle exec jekyll build"
end

task :favicon do
  # The Inkscape command-line on OSX only likes absolute paths
  input   = File.absolute_path "_resources/favicon.svg"
  output  = File.absolute_path "img/favicon.png"
  system "inkscape #{input} -e #{output}"
end