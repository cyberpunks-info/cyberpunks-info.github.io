module Images
  module_function

  def change_ext file, ext
    File.join(File.dirname(file), "%s.%s" % [File.basename(file, ".*"), ext])
  end

  def change_loc loc, file
    File.join loc, File.basename(file)
  end

  def inkscape input, output, height: 64
    system "inkscape '#{File.absolute_path input}' -h #{height} -e '#{File.absolute_path output}'"
  end

  module Optimize
    module_function

    def pngs *pngs
      pngs.each {|png| system "optipng -o7 '#{png}'"}
    end

    def jpgs *jpgs
      jpgs.each {|jpg| system "jpegrescan #{jpg} #{jpg}"}
    end
  end

  def optimize *pngs
    pngs.each {|png| system "optipng -o7 '#{png}'"}
  end

  def scale_image input, output, size
    image = MiniMagick::Image.open(input)

    w, h = image.dimensions

    crop = [h, h, (w-h)/2, 0]
    crop = [w, w, 0, (h-w)/2] if w < h

    image.crop("%sx%s+%s+%s" % crop)
    image.resize("%s>" % size)

    image.quality 90
    image.format "jpg"
    image.write output

    Optimize.jpgs output
  end

  def authors
    require "mini_magick"

    images = []

    Dir["_resources/authors/*"].each do |image|
      if image.end_with? ".svg"
        new_image = change_ext image, "png"
        inkscape image, new_image, height: 200
        images.push new_image
      elsif not File.file? change_ext(image, "svg")
        images.push image
      end
    end

    images.each do |image|
      scale_image image, change_loc("img/authors", change_ext(image, "jpg")), 200

      File.delete image if File.file? change_ext(image, "svg")
    end
  end
end
