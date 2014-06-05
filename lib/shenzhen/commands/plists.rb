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
