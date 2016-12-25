import XMonad
import XMonad.Core

import qualified XMonad.StackSet as W

import XMonad.Actions.CycleWS
import XMonad.Actions.CycleRecentWS

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicHooks
import XMonad.Hooks.ManageDocks

import XMonad.Layout
import XMonad.Layout.IM
import XMonad.Layout.Reflect
import XMonad.Layout.Tabbed       -- for simpleTabbed
import XMonad.Layout.GridVariants         --for Grids
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Named

import XMonad.Util.Run
import XMonad.Util.Replace
import System.Posix.Unistd
import System.Posix.User

import Data.Ratio ((%))
import Data.List

import qualified Data.Map as M
-- ******* Old Imports line by line. Remove or add back in as necessary. *****

import XMonad.ManageHook

--import XMonad.Actions.Promote

--import XMonad.Prompt
--import XMonad.Prompt.Man
--import XMonad.Prompt.Shell
--import XMonad.Hooks.UrgencyHook
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
--import XMonad.Util.EZConfig
--import System.IO
--import Network.BSD
--import Graphics.X11.Xlib


import XMonad.Hooks.EwmhDesktops

main = do
    myHost <- fmap nodeName getSystemID                                     --Get the hostname of the machine
    replace
    uid <- getRealUserID
    name <- getUserEntryForID uid
    return $  usrName name
    xmonad $ ewmh defaultConfig
        { manageHook = myManageHook <+> manageDocks
        , layoutHook = myLayoutHook
        , modMask = mod4Mask                                                --Rebind Mod to the Super key
        , terminal = myTerm                                          --Use urxvt clients
        , workspaces =  myWorkSpaces                                        --Custom workspaces
        , keys=myKeys myHost                                                --Keybindings
        }

-- Setup workspaces using short names to save display room
myWorkSpaces :: [String]
myWorkSpaces=["web","term","editor","im","t2","t3","mail","media","read", "vm", "ex"]

myTerm :: String
myTerm="urxvtc"

altMask :: KeyMask
altMask = mod1Mask

-- Get username
usrName :: UserEntry -> String
usrName (UserEntry x _ _ _ _ _ _) = x

-- Layout
myLayoutHook = avoidStruts
          $ onWorkspace "web" (Mirror myGrid ||| Full)
          $ onWorkspace "term" (Mirror myGrid ||| myGrid ||| Full)
          $ onWorkspace "editor" (Mirror myGrid ||| myGrid ||| Full)
          $ onWorkspace "im" (named "IM" (reflectHoriz $ withIM (1%5) (Title "Buddy List") (reflectHoriz $ Mirror myGrid ||| tall)))
          $ (myGrid ||| Mirror myGrid ||| Full)
          where
            tall   = Tall nmaster delta ratio
            nmaster = 1
            ratio   = 1/2
            delta   = 5/100
            defaultRatio = 1/2
            myGrid = named "g" (TallGrid 2 2 (1/2)  (1/2) (2/100))

-- Move some programs to certain workspaces and float some too
myManageHook = (composeAll . concat $
    [
       [className =? x --> doF (W.shift "web") | x <- myWebShift]
     , [className =? x --> doF (W.shift "im") | x <- myImShift]
     , [className =? x --> doF (W.shift "media") | x <- myMediaShift]
     , [className =? x --> doF (W.shift "doc") | x <- myDocShift]
     , [className =? x --> doF (W.shift "read") | x <- myReadShift]
     , [className =? x --> doF (W.shift "mail") | x <- myMailShift]
     , [className =? "VirtualBox"      --> doF (W.shift "vm")]
     , [className =? x --> doFloat | x <- myFloats]
     , [(className =? "Firefox" <&&> resource =? "Dialog") --> doFloat]     --Float Firefox Dialogs
   ])
   where
   myWebShift = ["Firefox","Chromium","Iceweasel","luakit", "Conkeror"]
   myImShift = ["Pidgin","Skype"]
   myDocShift = ["libreoffice-impress","libreoffice-writer","libreoffice-startcenter","Libreoffice","xpdf","Evince","Texmaker","Mirage","LibreOffice Calc"]
   myMediaShift = ["Banshee","Vlc","Rhythmbox","xine","Spotify","Steam"]
   myReadShift = ["Calibre","calibre"]
   myMailShift = ["Thunderbird"]
   myFloats = ["Gimp","Inkscape","Skype"]

{- Keybinding section
 - Union defaults
 - list new keybindings
 - Special keybindings by hostname
-}

-- Union default and new key bindings
myKeys hostname x  = M.union (M.fromList (newKeys hostname x)) (keys defaultConfig x)

-- Add new and/or redefine key bindings
newKeys hostname conf@(XConfig {XMonad.modMask = modMask}) = [
   ((modMask .|. controlMask, xK_r), spawn "xrandr --output VGA-0 --auto")  -- Resize vbox screen
 , ((modMask .|. controlMask, xK_s), spawn "scrot -s")
 , ((modMask .|. controlMask, xK_Down), shiftToNext)                        --Move around screens
 , ((modMask .|. controlMask, xK_Up), shiftToPrev)                          --Move around screens
 , ((modMask .|. controlMask, xK_Right), nextScreen)                        --Move around screens
 , ((modMask .|. controlMask, xK_Left),  prevScreen)
 , ((modMask, xK_equal), nextWS)                                            --Cycle through WorkSpaces
 , ((modMask, xK_minus), prevWS)
 , ((modMask .|. shiftMask, xK_Right), shiftNextScreen)                     --Move things around screens
 , ((modMask .|. shiftMask, xK_Left), shiftPrevScreen)
                                                                            -- Add shortcuts for programs
 , ((modMask .|. shiftMask, xK_b), spawn "calibre")
 , ((modMask .|. shiftMask, xK_c), spawn "chrome")
 , ((modMask .|. shiftMask, xK_e), spawn "emacs")
 , ((modMask .|. shiftMask, xK_f), spawn "firefox")
 , ((modMask .|. shiftMask, xK_p), spawn "pidgin")
 , ((modMask .|. shiftMask, xK_r), spawn "rhythmbox")
 , ((modMask .|. shiftMask, xK_s), spawn "spotify")
 , ((modMask .|. shiftMask, xK_t), spawn "thunderbird")
 , ((modMask .|. shiftMask, xK_v), spawn "VirtualBox")
-- , ((modMask .|. shiftMask, xK_z), spawn "zsnes")
 -- , ((modMask .|. shiftMask .|. controlMask, xK_End), spawn "sudo pm-suspend")
 ]

 ++
 if( hostname =="charmy")                                                   --if laptop hostname set specific keybindings
   then [
   ((0, 0x1008ff13), spawn "amixer set Master 2dB+")
 , ((0,0x1008ff11), spawn "amixer set Master 2dB-")
 ]
   else [ ]                                                                 --Otherwise nothing
