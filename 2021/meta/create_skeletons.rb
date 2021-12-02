#!/usr/bin/ruby

days_to_create = 1..25

days_to_create.each do |daynum|
  template ||= File.read('meta/tmpl')

  [1,2].each do |partnum|
    filename = "%s_%s.rb" % [daynum, partnum]

    next if File.exists?(filename)

    replacements = {
      "PUZZLENUM" => ((daynum-1)*2 + partnum).to_s,
      "DAYNUM"    => daynum.to_s,
      "PARTNUM"   => partnum.to_s
    }

    File.write(filename, template.gsub(/(#{replacements.keys.join("|")})/,
                                       replacements))
  end
end

exit 0
