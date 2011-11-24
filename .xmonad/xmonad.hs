import XMonad
import XMonad.Core

import XMonad hiding ((|||))
import XMonad.ManageHook
import qualified XMonad.StackSet as W

import XMonad.Actions.CycleWS
import XMonad.Actions.Promote

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Man

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook

import XMonad.Layout
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile

import XMonad.Util.Run
import XMonad.Util.EZConfig
import System.IO

import Graphics.X11.Xlib
import qualified Data.Map as M


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/trevis/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = myManageHook 
        , layoutHook = myLayoutHook  -- $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , terminal = "urxvtc"    -- Use urxvt clients
        , workspaces = myWorkSpaces
        , keys=myKeys
        }
-- Setup workspaces using short names to save display room        
myWorkSpaces=["term","web","code","ppl","fm","6:","7:","8:","music"]

-- Layout
myLayoutHook = avoidStruts (tall ||| Full)
  where
     tall   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 2/100
         
-- Move some programs to certain workspaces         
myManageHook = composeAll
   [   className =? "Gimp"           --> doFloat
     , className =? "Pidgin"         --> doF (W.shift "ppl")
     , className =? "Firefox"        --> doF (W.shift "web")
     , className =? "Opera"          --> doF (W.shift "web")
     , className =? "xchat"          --> doF (W.shift "ppl")
     , className =? "Banshee"        --> doF (W.shift "music")
     , className =? "Skype"          --> doF (W.shift "ppl")
     , className =? "Thunar"         --> doF (W.shift "fm")
     , className =? "Pidgin"         --> doFloat
     , className =? "Skype"          --> doFloat
   ] <+> manageDocks <+> manageHook defaultConfig


-- Union default and new key bindings
myKeys x  = M.union (M.fromList (newKeys x)) (keys defaultConfig x)
 
-- Add new and/or redefine key bindings
newKeys conf@(XConfig {XMonad.modMask = modMask}) = [
  (( modMask .|. shiftMask, xK_e), spawn "eject -T")
  ]
