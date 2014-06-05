$:.push File.expand_path('../', __FILE__)

require 'plugins/testflight'
require 'plugins/hockeyapp'
require 'plugins/ftp'
require 'plugins/s3'
require 'plugins/deploygate'

require 'commands/build'
require 'commands/distribute'
require 'commands/info'
require 'commands/pget'
require 'commands/pset'
require 'commands/bump'
require 'commands/plists'