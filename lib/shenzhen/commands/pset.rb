command :pset do |c|
  c.syntax = 'ipa pset <key> <value> [options]'
  c.summary = 'Set the value in a plist'
  c.description = ''
  c.option '-p', '--plist FILE', "plist file to update"

  c.action do |args, options|
    say_error "Missing key and value" and abort unless args.count == 2
    key, value = args

    determine_plist! unless @plist = options.plist
    say_error "Missing or unspecified .plist file" and abort unless @plist and File.exist?(@plist)

    value = Shenzhen::PlistBuddy.set(@plist, key, value)
    say_error "Key '#{key}' not found in #{@plist}" and abort if value.nil?
  end
end