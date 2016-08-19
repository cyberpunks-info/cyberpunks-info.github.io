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
  
  # Export the image at the default 64x resolution
  system "inkscape #{input} -e #{output}"

  # And optimize
  system "optipng -o7 #{output}"
end

task :compressor do
  require "open-uri"
  require "json"
  require "zipruby"
  
  url = "https://api.github.com/repos/penibelst/jekyll-compress-html/releases"
  output = "_layouts/compress.html"

  puts "Accessing github api..."

  # Get releases for the compressor
  latest = JSON.load(open(url).read).first
  

  puts "Downloading #{latest["name"]}..."

  # Download the latest zip release
  zip = latest["assets"].first["browser_download_url"]
  archive = Zip::Archive.open_buffer(open(zip).read)

  # Get out the text
  text = archive.map{|file| file.read}.first

  # Write the text to a file
  if File.write(output, text)
    puts "Written to '#{output}'."
  else
    puts "Cannot write to '#{output}'."
  end
end
