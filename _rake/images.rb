module Images
  # Use mkmf for finding executables
  require "mkmf"

  module_function

  def inkscape input, output, height: 64
    if find_executable "inkscape"
      system "inkscape '#{File.absolute_path input}' -h #{height} -e '#{File.absolute_path output}'"
    else
      puts "Please install inkscape."
    end
  end

  def optimize *pngs
    if find_executable "optipng"
      pngs.each {|png| system "optipng -o7 '#{png}'"}
    else
      puts "Please install optipng to optimize png files."
    end
  end
end
