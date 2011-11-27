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
import System.IO.Unsafe
import System.Posix.Unistd

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
        , workspaces =  myWorkSpaces
        , keys=myKeys
        }
-- Setup workspaces using short names to save display room        
myWorkSpaces=["term","web","code","ppl","fm","6:","7:","8:","media"]

-- Layout
myLayoutHook = avoidStruts (tall ||| Full)
  where
     tall   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 2/100
         
-- Move some programs to certain workspaces and float some too         
myManageHook = composeAll
    [
       className =? "Firefox"        --> doF (W.shift "web")
     , className =? "Opera"          --> doF (W.shift "web")
     , className =? "Pidgin"         --> doF (W.shift "ppl")
     , className =? "xchat"          --> doF (W.shift "ppl")
     , className =? "Skype"          --> doF (W.shift "ppl")
     , className =? "Thunar"         --> doF (W.shift "fm")
     , className =? "Banshee"        --> doF (W.shift "media")
     , className =? "Vlc"            --> doF (W.shift "media")
     , className =? "Pidgin"         --> doFloat
     , className =? "Skype"          --> doFloat
     , className =? "Gimp"           --> doFloat
     , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialogs
   ] <+> manageDocks <+> manageHook defaultConfig


-- Union default and new key bindings
myKeys x  = M.union (M.fromList (newKeys x)) (keys defaultConfig x)

myHost= fmap  nodeName getSystemID   --Get the hostname of the machine

-- Add new and/or redefine key bindings
newKeys conf@(XConfig {XMonad.modMask = modMask}) = [
  (( modMask .|. shiftMask, xK_e), spawn "eject -T")               --Keyboard shortcut for eject, usefull on slot load
 , ((modMask .|. controlMask, xK_Right), nextScreen)               --Move around screens
 , ((modMask .|. controlMask, xK_Left),  prevScreen)
 , ((modMask .|. shiftMask, xK_Right), shiftNextScreen)
 , ((modMask .|. shiftMask, xK_Left), shiftPrevScreen)
 ]

 ++
 if( (unsafePerformIO myHost) =="charmy")    --Unsafe IO, but if laptop hostname then set specific keybindings
   then [ 
   ((0, 0x1008ff13), spawn "amixer set Master 2dB+") 
 , ((0,0x1008ff11), spawn "amixer set Master 2dB-")  
 ]
   else [ ]                                 -- If not laptop then no additional keybindings
