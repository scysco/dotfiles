-------------------------------------------------------------------------------
-- Import modules                                                            --
-------------------------------------------------------------------------------
import Control.Monad (liftM2)          -- myManageHookShift
import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import System.IO                       -- for xmobar

import XMonad

import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.FloatKeys
import XMonad.Actions.Navigation2D
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WindowGo
import XMonad.Config.Desktop

import XMonad.Hooks.DynamicLog         -- for xmobar
import XMonad.Hooks.EwmhDesktops       -- to automaticly expand fullscreen apps
import XMonad.Hooks.ManageDocks        -- avoid xmobar area
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName          -- to fix java's grey windows
import XMonad.Hooks.UrgencyHook

import XMonad.Layout
import XMonad.Layout.DragPane          -- see only two window
import XMonad.Layout.Fullscreen        -- to manualy expend app to fullscreen
import XMonad.Layout.Gaps
import XMonad.Layout.HintedGrid
import XMonad.Layout.LayoutScreens
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Named
import XMonad.Layout.NoBorders         -- In Full mode, border is no use
import XMonad.Layout.PerWorkspace      -- Configure layouts on a per-workspace
import XMonad.Layout.ResizableTile     -- Resizable Horizontal border
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing           -- this makes smart space around windows
import XMonad.Layout.ToggleLayouts     -- Full window at any time
import XMonad.Layout.TwoPane

import XMonad.Prompt
import XMonad.Prompt.Window            -- pops up a prompt with window names
import XMonad.Util.EZConfig            -- removeKeys, additionalKeys
import XMonad.Util.NamedScratchpad
import XMonad.Util.NamedWindows
import XMonad.Util.Run
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Util.SpawnOnce
import XMonad.Util.WorkspaceCompare

import qualified Data.Map as M
import qualified XMonad.Actions.FlexibleResize as Flex -- flexible resize
import qualified XMonad.StackSet as W  -- myManageHookShift

-------------------------------------------------------------------------------
-- local variables                                                           --
-------------------------------------------------------------------------------

myWorkspaces = ["1", "2", "3", "4", "5","6","7","8","9"]
modm = mod4Mask

-- Color Setting
colorBlue      = "#868bae"
colorGreen     = "#00d700"
colorRed       = "#ff005f"
colorGray      = "#666666"
colorWhite     = "#bdbdbd"
colorNormalbg  = "#1c1c1c"
colorfg        = "#a8b6b8"

-- Border width
borderwidth = 1

-- Border color
mynormalBorderColor  = "#262626"
myfocusedBorderColor = "#ededed"

-----------------------------------------------------------------------------
-- main                                                                      --
-------------------------------------------------------------------------------

main :: IO ()

main = do
    xmproc <- spawnPipe "sh ~/.fehbg"
    xmproc <- spawnPipe "urxvtd -o -q -f"
    wsbar <- spawnPipe myWsBar
    xmproc <- spawnPipe "sleep 3 && ~/.bin/trayer.sh"
    xmonad $ withNavigation2DConfig myNavigation2DConfig
	   $ withUrgencyHookC NoUrgencyHook urgencyConfig{ suppressWhen = Focused }	
	   $ ewmh 
	   $ defaultConfig
       { borderWidth        = borderwidth
       , modMask            = modm
       , terminal           = "termite"
       , workspaces         = myWorkspaces
       , focusFollowsMouse  = True
       , normalBorderColor  = mynormalBorderColor
       , focusedBorderColor = myfocusedBorderColor
       , logHook            = myLogHook wsbar
                                -- >> updatePointer (Relative 0.5 0.5)
       , layoutHook         = mkToggle (single NBFULL) $ avoidStruts myLayout
       , manageHook         = myManageHook <+> manageHook desktopConfig
       , handleEventHook    = myEventHook
       , mouseBindings      = newMouse
       , startupHook        = docksStartupHook <+> setWMName "LG3D"        
       }

       ------------------------------------------------------------------------
       -- Define keys to remove                                              --
       ------------------------------------------------------------------------

       `removeKeysP`
       [
       ]

       ------------------------------------------------------------------------
       -- Keymap: window operations                                          --
       ------------------------------------------------------------------------

       `additionalKeysP`
       [-- Toggle layout (Fullscreen mode)
 	 ("M-f"    , sendMessage ToggleLayout)
       -- Search a window and focus into the window
       , ("M-g"    , windowPromptGoto myXPConfig)
       -- Search a window and bring to the current workspace
       , ("M-b"    , windowPromptBring myXPConfig)
       -- Now we have more than one screen by dividing a single screen
       , ("M-C-<Space>", layoutScreens 2 (TwoPane 0.5 0.5))
       , ("M-C-S-<Space>", rescreen)
       ]

       -------------------------------------------------------------------- }}}
       -- Keymap: Manage workspace                                          {{{
       ------------------------------------------------------------------------
       -- mod-[1..9]          Switch to workspace N
       -- mod-shift-[1..9]    Move window to workspace N
       -- mod-control-[1..9]  Copy window to workspace N

       --`additionalKeys`
       --[ ((m .|. modm, k), windows $ f i)
       --  | (i, k) <- zip myWorkspaces [xK_1 ..]
       --  , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask), (copy, controlMask)]
       --]

       -------------------------------------------------------------------- }}}
       -- Keymap: custom commands                                           {{{
       ------------------------------------------------------------------------

       `additionalKeysP`
       [("M-<Return>", spawn "termite")
       -- Launch file manager
       , ("M-e", spawn "termite -e ranger")
       -- Launch web browser
       , ("M-w", spawn "luakit")
       -- Launch dmenu for launching applicatiton
       , ("M-p", spawn "exe=`dmenu_run -fn 'Migu 1M:size=10'` && exec $exe")
       -- Play / Pause media keys
       , ("M-<F7>", spawn "playerctl play-pause")
       , ("M-<F8>", spawn "playerctl next")
       , ("M-<F6>", spawn "playerctl prev")
       -- Volume setting media keys
       , ("<XF86AudioRaiseVolume>",   spawn "~/.bin/AudioVolume.sh +")
       , ("<XF86AudioLowerVolume>",   spawn "~/.bin/AudioVolume.sh -")
       , ("<XF86AudioMute>",          spawn "~/.bin/AudioVolume.sh m")
        -- Brightness Keys
       , ("<XF86MonBrightnessUp>"  , spawn "~/.bin/BrightnessChange.sh +")
       , ("<XF86MonBrightnessDown>", spawn "~/.bin/BrightnessChange.sh -")
       -- Take a screenshot (whole window)
       , ("<Print>", spawn "~/.bin/screenshot.sh")
       -- Take a screenshot (selected area)
       , ("S-<Print>", spawn "~/.bin/screenshot_select.sh")
       -- Toggle touchpad
       , ("M-<F5>", spawn "~/.bin/touchpad_toggle.sh")
       ]

--------------------------------------------------------------------------- }}}
-- myLayout:          Handle Window behaveior                               {{{
-------------------------------------------------------------------------------

myLayout
    = smartBorders
    $ tiled |||
      (Mirror tiled) |||
      full
    where
        spaces   = spacing 4
        tiled    = spaces $ ResizableTall nmaster delta ratio []
        full     = Full
        nmaster  = 1
        ratio    = 1/2
	delta    = 3/100
--------------------------------------------------------------------------- }}}
-- myStartupHook:     Start up applications                                 {{{
-------------------------------------------------------------------------------

--myStartupHook = do
--        spawnOnce "sh ~/.fehbg"
--    	  spawnOnce "stalonetray &"

--------------------------------------------------------------------------- }}}
-- myManageHook:         managehock settings                                      {{{
-------------------------------------------------------------------------------
myManageHook = composeAll
    [ manageDocks
    , fullscreenManageHook
    --, namedScratchpadManageHook myScratchPads
    , isFullscreen                      --> doFullFloat
    , className =? "NeercGame"          --> doFloat
    , isDialog                          --> doCenterFloat
    , resource  =? "desktop_window"     --> doIgnore
    , className =? "firefox"              --> doShift "1"
    , isFullscreen                      --> doFullFloat
    ]	

--------------------------------------------------------------------------- }}}
-- myLogHook:         loghock settings                                      {{{
-------------------------------------------------------------------------------

myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h } 
--------------------------------------------------------------------------- }}}
-- myEventHook:         eventhock settings                                  {{{
-------------------------------------------------------------------------------

myEventHook = docksEventHook <+> XMonad.Hooks.EwmhDesktops.fullscreenEventHook

--------------------------------------------------------------------------- }}}
-- myWsBar:           xmobar setting                                        {{{
-------------------------------------------------------------------------------

myWsBar = "xmobar $HOME/.xmonad/xmobarrc"

wsPP = xmobarPP { ppOrder           = \(ws:l:t:_)  -> [ws,t]
                , ppCurrent         = xmobarColor colorRed  colorNormalbg . \s -> "●"
                , ppUrgent          = xmobarColor colorGray colorNormalbg . \s -> "●"
                , ppVisible         = xmobarColor colorRed  colorNormalbg . \s -> "⦿"
                , ppHidden          = xmobarColor colorGray colorNormalbg . \s -> "●"
                , ppHiddenNoWindows = xmobarColor colorGray colorNormalbg . \s -> "○"
                , ppTitle           = xmobarColor colorRed  colorNormalbg
                , ppOutput          = putStrLn
                , ppWsSep           = " "
                , ppSep             = "  "
                }

--------------------------------------------------------------------------- }}}
-- myXPConfig:        XPConfig                                            {{{

myXPConfig = defaultXPConfig
                { font              = "xft:Migu 1M:size=12:antialias=true"
                , fgColor           = colorfg
                , bgColor           = colorNormalbg
                , borderColor       = colorNormalbg
                , height            = 15
                , promptBorderWidth = 0
                , autoComplete      = Just 100000
                , bgHLight          = colorNormalbg
                , fgHLight          = colorRed
                , position          = Bottom
                }
--------------------------------------------------------------------------- }}}
-- myWsBar:           xmobar setting                                        {{{
-------------------------------------------------------------------------------

myNavigation2DConfig = def {
    defaultTiledNavigation = centerNavigation
}

--------------------------------------------------------------------------- }}}
-- newMouse:          Right click is used for resizing window               {{{
-------------------------------------------------------------------------------

myMouse x = [ ((modm, button3), (\w -> focus w >> Flex.mouseResizeWindow w)) ]
newMouse x = M.union (mouseBindings defaultConfig x) (M.fromList (myMouse x))

--------------------------------------------------------------------------- }}}
-- Notify OSD:                                                              {{{
-------------------------------------------------------------------------------

data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- fmap (W.findTag w) $ gets windowset

        safeSpawn "notify-send" [show name, "workspace " ++ idx]

--------------------------------------------------------------------------- }}}
-- vim: ft=haskell
