# A wrapper for the inkscape command-line.
# On OSX it only likes absolute paths.
def inkscape input, output, height: 64
  sh "inkscape '#{File.absolute_path input}' -h #{height} -e '#{File.absolute_path output}'"
end

# Require multiple gems on a single line
def require_all *gems
  gems.each {|req_gem| require req_gem}
end

desc "Serve the site through jekyll"
task :serve do; sh "bundle exec jekyll serve"; end

desc "Build the site through jekyll"
task :build do; sh "bundle exec jekyll build"; end

desc "Output and optimize the site favicon"
task :favicon do
  output = "img/favicon.png"

  # Export the image at the default 64x resolution
  inkscape "_resources/favicon.svg", output

  # And optimize
  sh "optipng -o7 #{output}"
end

task :compressor do
  require_all "open-uri", "json", "zipruby"

  url = "https://api.github.com/repos/penibelst/jekyll-compress-html/releases"
  output = "_layouts/compress.html"

  # Get releases for the compressor
  puts "Accessing github api..."
  latest = JSON.load(open(url).read).first

  # Download the latest zip release
  puts "Downloading #{latest["name"]}..."
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
