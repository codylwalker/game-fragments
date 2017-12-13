-- initialise stuff
import = require 'util.import'
require 'util.strict'
require 'util.init_love_events'
require 'util.init_standard_controls'

-- util library
local library = require 'util.library'
return library (...,
  'class',
  'Color',
  'Context',
  'Event',
  'graphics',
  'help',
  'import',
  'library',
  'List',
  'v2',
  'Vec2',
  'Box'
)
