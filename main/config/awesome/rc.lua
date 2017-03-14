local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}


-- global variables
modkey = "Mod4"
wallpaper = "/home/meu/.local/wallpaper.jpg"
terminal = "lilyterm"
locker= "slock"
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
}


-- Themes, wallpapers {{{
beautiful.init(awful.util.get_themes_dir() .. "default/theme.lua")
-- sitty beautiful rewrite
beautiful.font = "Ricty Diminished 10"
if awful.util.file_readable(wallpaper) then
    beautiful.wallpaper = wallpaper
end

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end
screen.connect_signal("property::geometry", set_wallpaper)
-- }}}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("%H:%M:%S", 1)

-- taglist / taglist callbacks
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end)
                )

local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              -- Without this, the following
                                              -- :isvisible() makes no sense
                                              c.minimized = false
                                              if not c:isvisible() and c.first_tag then
                                                  c.first_tag:view_only()
                                              end
                                              -- This will also un-minimize
                                              -- the client, if needed
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(
        s, awful.widget.taglist.filter.all, taglist_buttons,
        {font = beautiful.font}
    )

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(
        s, awful.widget.tasklist.filter.currenttags, tasklist_buttons,
        {tasklist_disable_icon = true, font = beautiful.font}
    )

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mytextclock,
            wibox.widget.systray(),
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Key bindings
-- root
globalkeys = awful.util.table.join(
    -- focusing
    awful.key({modkey}, "j", function () awful.client.focus.byidx( 1) end),
    awful.key({modkey}, "k", function () awful.client.focus.byidx(-1) end),
    awful.key({modkey}, "l", function ()  awful.client.swap.byidx( 1) end),
    awful.key({modkey}, "h", function ()  awful.client.swap.byidx(-1) end),

    -- Layout adjustment
    awful.key({modkey, "Control"}, "j",
        function () awful.screen.focus_relative(1) end),
    awful.key({modkey, "Control"}, "k",
        function () awful.screen.focus_relative(-1) end),
    awful.key({modkey, "Shift"}, "l",
        function () awful.tag.incmwfact( 0.05) end),
    awful.key({modkey, "Shift"}, "h",
        function () awful.tag.incmwfact(-0.05) end),

    -- Layout switching
    awful.key({modkey}, "Return", function () awful.layout.inc( 1) end),
    awful.key({modkey, "Shift"}, "Return", function () awful.layout.inc(-1) end),

    -- awesome systems
    awful.key({modkey, "Control"}, "r", awesome.restart),
    awful.key({modkey, "Shift"}, "q", awesome.quit),
    awful.key({modkey}, "b",
        function ()
            local myscreen = awful.screen.focused()
            myscreen.mywibox.visible = not myscreen.mywibox.visible
        end
    ),

    -- program launcher
    awful.key({modkey}, "space",
        function () awful.screen.focused().mypromptbox:run() end),

    awful.key({modkey}, "c", function () awful.spawn(terminal) end),
    awful.key({modkey}, "q", function () awful.spawn(locker) end),
    awful.key({}, "XF86AudioRaiseVolume",
        function() awful.spawn("amixer sset Master 5%+") end),
    awful.key({}, "XF86AudioLowerVolume",
        function() awful.spawn("amixer sset Master 5%-") end),
    awful.key({}, "XF86AudioMute",
        function() awful.spawn("amixer sset Master toggle") end),
    awful.key({}, "XF86MonBrightnessUp",
        function() awful.spawn("xbacklight -inc 10") end),
    awful.key({}, "XF86MonBrightnessDown",
        function() awful.spawn("xbacklight -dec 10") end),

    -- Super_L(binded to modkey) + P is assigned at F6 in Mi Notebook
    awful.key({modkey}, "P",
        function() awful.spawn("xset dpms force off") end),
    -- Super_L(binded to modkey) + Tab is assigned at F8 in Mi Notebook
    awful.key({modkey}, "Tab",
        function() awful.spawn("xrandr --auto") end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key(
            {modkey}, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end
        ),
        -- Toggle tag display.
        awful.key(
            {modkey, "Control"}, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end
        ),
        -- Move client to tag.
        awful.key(
            {modkey, "Shift"}, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end
        ),
        -- Toggle tag on focused client.
        awful.key(
            {modkey, "Control", "Shift"}, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end
        )
    )
end

root.keys(globalkeys)

-- client
clientkeys = awful.util.table.join(
    awful.key({modkey, "Shift"}, "c", function (c) c:kill() end),
    awful.key({modkey, "Control"}, "space",
        function (c)
            c.floating = not c.floating;
            c.ontop = c.floating
        end
    ),
    awful.key(
        {modkey, "Shift"}, "space",
        function (c) c.ontop = not c.ontop end
    ),
    awful.key(
        {modkey}, "m",
        function (c)
            c.maximized = not c.maximized;
            c:raise()
        end
    )
)


clientbuttons = awful.util.table.join(
    awful.button({}, 1,
        function (c)
            client.focus = c;
            c:raise()
        end
    ),
    awful.button({modkey}, 1, awful.mouse.client.move),
    awful.button({modkey}, 3, awful.mouse.client.resize)
)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
