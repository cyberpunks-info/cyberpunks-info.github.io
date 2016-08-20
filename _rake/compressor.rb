def download_compressor
    require "open-uri"
    require "json"
    require "zipruby"

    repo = "penibelst/jekyll-compress-html"
    puts "Downloading #{repo}.."
    url = "https://api.github.com/repos/#{repo}/releases"
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
    puts (File.write(output, text) ? "Written to '#{output}'." : "Cannot write to '#{output}'.")
end
