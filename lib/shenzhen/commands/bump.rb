valid_key_types = ['date', 'number']

command :bump do |c|
  c.syntax = 'ipa bump <key> [options]'
  c.summary = 'Bump a value in a plist - defaults to build number'
  c.option '-p', '--plist FILE', "plist file to update"
  c.option '-y', '--type TYPE', "type of key (#{valid_key_types.join ', '})"
  c.option '-f', '--format FORMAT', "format for the type, defaults to : '%m/%d/%Y %H:%M:%S'"

  c.action do |args, options|
    @key = args.count > 0 ? args[0] : 'CFBundleVersion'
    @type_of = options.type || 'number'
    @format = options.format

    determine_plist! unless @plist = options.plist
    say_error "Missing or unspecified .plist file" and abort unless @plist and File.exist?(@plist)

    @value = Shenzhen::PlistBuddy.print(@plist, @key)
    say_error "Key '#{@key}' not found in #{@plist}" and abort if @value.nil?

    case @type_of
      when "date" then bump_date
      when "number" then bump_number
      else
        say_error "Invalid key type '#{@type_of}' - choices are (#{valid_key_types.join ', '})"
    end

    puts Shenzhen::PlistBuddy.set(@plist, @key, @value)

  end

  private

  def bump_date
    @value = Time.new.strftime(@format || '%m/%d/%Y %H:%M:%S')
  end

  def bump_number
    say_error "Invalid value '#{@value}' for key '#{@key}'" and abort unless @value =~ /^\d+$/
    @value = @value.to_i + 1
  end
end



#    set_ios_build_number($path_to_manifest, $new_build);
#    set_ios_build_date($path_to_manifest, date('m/d/y H:i:s'));