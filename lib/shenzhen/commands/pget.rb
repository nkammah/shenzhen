require 'plist'

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

  private

  def determine_plist!
    plist = Dir["**/*-Info.plist"].reject {|p|p =~ /^Libraries\// || p =~ /^bin\//}
    @plist ||= case plist.length
              when 0 then nil
              when 1 then plist.first
              else
                @plist = choose "Select a plist File:", *plist
              end
  end
end
