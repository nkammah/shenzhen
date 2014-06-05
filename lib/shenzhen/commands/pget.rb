command :pget do |c|
  c.syntax = 'ipa pget <key> [options]'
  c.summary = 'Retrieve a value in a plist'
  c.description = ''
  c.option '-p', '--plist FILE', "plist file to update"


  c.action do |args, options|
    @key = args.count > 0 ? args[0] : 'CFBundleShortVersionString'
    determine_plist! unless @plist = options.plist
    say_error "Missing or unspecified .plist file" and abort unless @plist and File.exist?(@plist)

    puts Shenzhen::PlistBuddy.print(@plist, @key)
  end

end
