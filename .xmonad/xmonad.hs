import XMonad

import qualified XMonad.StackSet as W

import XMonad.Actions.CycleWS

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Layout
import XMonad.Layout.IM
import XMonad.Layout.Reflect
import XMonad.Layout.Tabbed       -- for simpleTabbed
import XMonad.Layout.GridVariants         --for Grids
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Named

import XMonad.Util.Run
import System.IO.Unsafe
import System.Posix.Unistd

import Data.Ratio ((%))

import qualified Data.Map as M
-- ******* Old Imports line by line. Remove or add back in as necessary. *****

--import XMonad.Core
--import XMonad.ManageHook

--import XMonad.Actions.Promote

--import XMonad.Prompt
--import XMonad.Prompt.Man
--import XMonad.Prompt.Shell
--import XMonad.Hooks.UrgencyHook
--import XMonad.Layout.NoBorders
--import XMonad.Layout.ResizableTile
--import XMonad.Util.EZConfig
--import System.IO
--import Network.BSD
--import Graphics.X11.Xlib

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/trevis/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = myManageHook <+> manageDocks <+> manageHook defaultConfig
        , layoutHook = myLayoutHook  -- $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Super key
        , terminal = "urxvtc"    -- Use urxvt clients
        , workspaces =  myWorkSpaces
        , keys=myKeys
        }
-- Setup workspaces using short names to save display room        
myWorkSpaces=["term","web","code","ppl","fm","doc","vm","media","stch","scratch"]

-- Layout
myLayoutHook = avoidStruts  $ onWorkspace "term" (myGrid ||| simpleTabbed ||| Full) $ onWorkspace "code" (myGrid ||| simpleTabbed ||| Full) $ onWorkspace "ppl" (named "IM" (reflectHoriz $ withIM (1%15) (Title "Buddy List") (reflectHoriz $ myGrid ||| tall)))  $ onWorkspace "web" (simpleTabbed ||| Full ||| tall) $ (tall ||| myGrid ||| Full ||| simpleTabbed )
  where
     tall   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 2/100
     defaultRatio = 1/2
     myGrid = named "g" (TallGrid 2 2 (1/2)  (1/2) (2/100))
         
-- Move some programs to certain workspaces and float some too         
myManageHook = (composeAll . concat $
    [
       [className =? x --> doF (W.shift "web") | x <- myWebShift]
     , [className =? x --> doF (W.shift "ppl") | x <- myImShift]
     , [className =? x --> doF (W.shift "media") | x <- myMediaShift]
     , [className =? x --> doF (W.shift "doc") | x <- myDocShift]
     , [className =? "VirtualBox"      --> doF (W.shift "vm")]
     , [className =? "Thunar"         --> doF (W.shift "fm")]
     , [className =? x --> doFloat | x <- myFloats]
     , [(className =? "Firefox" <&&> resource =? "Dialog") --> doFloat]  -- Float Firefox Dialogs
   ])
   where
   myWebShift = ["Firefox","luakit","Opera"]
   myImShift = ["Pidgin","Skype"]
   myDocShift = ["libreoffice-writer","libreoffice-startcenter","Libreoffice","xpdf","Evince","Texmaker","Mirage"]
   myMediaShift = ["Banshee","Vlc","Rhythmbox","xine"]
   myFloats =["Pidgin","Skype","Gimp"]

-- Union default and new key bindings
myKeys x  = M.union (M.fromList (newKeys x)) (keys defaultConfig x)

myHost = fmap  nodeName getSystemID   --Get the hostname of the machine

-- Add new and/or redefine key bindings
newKeys conf@(XConfig {XMonad.modMask = modMask}) = [
  (( modMask .|. controlMask, xK_e), spawn "eject -T")               --Keyboard shortcut for eject, usefull on slot load
 , ((modMask .|. controlMask, xK_Right), nextScreen)               --Move around screens
 , ((modMask .|. controlMask, xK_Left),  prevScreen)
 , ((modMask, xK_equal), nextWS)                                   --Cycle through WorkSpaces
 , ((modMask, xK_minus), prevWS)
 , ((modMask .|. shiftMask, xK_Right), shiftNextScreen)            --Move things around screens
 , ((modMask .|. shiftMask, xK_Left), shiftPrevScreen)
 , ((modMask .|. shiftMask, xK_b), spawn "banshee")
 , ((modMask .|. shiftMask, xK_c), spawn "texmaker")
 , ((modMask .|. shiftMask, xK_e), spawn "evince")
 , ((modMask .|. shiftMask, xK_f), spawn "firefox")
 , ((modMask .|. shiftMask, xK_l), spawn "luakit")
 , ((modMask .|. shiftMask, xK_m), spawn "mirage")                                
 , ((modMask .|. shiftMask, xK_o), spawn "opera")                                
 , ((modMask .|. shiftMask, xK_p), spawn "pidgin")
 , ((modMask .|. shiftMask, xK_r), spawn "rhythmbox")
 , ((modMask .|. shiftMask, xK_s), spawn "skype")
 , ((modMask .|. shiftMask, xK_t), spawn "thunar")
 , ((modMask .|. shiftMask, xK_v), spawn "virtualbox") 
 , ((modMask .|. shiftMask, xK_z), spawn "zsnes") 
 , ((modMask .|. shiftMask, xK_9), spawn "xine")
 , ((modMask .|. shiftMask .|. controlMask, xK_End), spawn "sudo pm-suspend")    
 ]

 ++
 if( (unsafePerformIO myHost) =="charmy")    --Unsafe IO, but if laptop hostname then set specific keybindings
   then [ 
   ((0, 0x1008ff13), spawn "amixer set Master 2dB+") 
 , ((0,0x1008ff11), spawn "amixer set Master 2dB-")  
 ]
   else [ ]                                 -- If not laptop then no additional keybindings
