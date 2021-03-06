--[[
             __________               __   ___.
   Open      \______   \ ____   ____ |  | _\_ |__   _______  ___
   Source     |       _//  _ \_/ ___\|  |/ /| __ \ /  _ \  \/  /
   Jukebox    |    |   (  <_> )  \___|    < | \_\ (  <_> > <  <
   Firmware   |____|_  /\____/ \___  >__|_ \|___  /\____/__/\_ \
                     \/            \/     \/    \/            \/
 $Id$
 Example Lua File Viewer script
 Copyright (C) 2017 William Wilgus
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
 KIND, either express or implied.
]]--

require("actions")   -- Contains rb.actions & rb.contexts
-- require("buttons") -- Contains rb.buttons -- not needed for this example

--local _timer = require("timer")
--local _clr   = require("color") -- clrset, clrinc provides device independent colors
local _lcd   = require("lcd")   -- lcd helper functions
--local _print = require("print") -- advanced text printing
--local _img   = require("image") -- image manipulation save, rotate, resize, tile, new, load
--local _blit  = require("blit") -- handy list of blit operations
--local _draw  = require("draw") -- draw all the things (primitives)
--local _math  = require("math_ex") -- missing math sine cosine, sqrt, clamp functions


local scrpath = rb.current_path()--rb.PLUGIN_DIR .. "/demos/lua_scripts/"

package.path = scrpath .. "/?.lua;" .. package.path --add lua_scripts directory to path

require("printmenu") --menu
require("filebrowse") -- file browser
require("fileviewers") -- fileviewer, hexviewer

rb.actions = nil
package.loaded["actions"] = nil

-- uses print_table to display a menu
function main_menu()

    local mt =  {
                [1] = "Rocklua File View Example",
                [2] = "File View",
                [3] = "File Hex View",
                [4] = "Simple Browser",
                [5] = "Exit"
                }

    local ft =  {
                [0] = exit_now, --if user cancels do this function
                [1] = function(TITLE) return true end, -- shouldn't happen title occupies this slot
                [2]  = function(VIEWF) -- view file
                            print_file_increment(file_choose("/", "Choose File"))
                        end,
                [3]  = function(VHEXF) -- view hex
                            print_file_hex(file_choose("/", "Choose File"), 8)
                        end,
                [4]  = function(BROWS) -- file browser
                            _lcd:splashf(rb.HZ, "%s", file_choose("/") or "None")
                        end,
                [5] = function(EXIT_) return true end
                }

    print_menu(mt, ft)

end

function exit_now()
    _lcd:update()
    os.exit()
end -- exit_now

main_menu()
exit_now()
