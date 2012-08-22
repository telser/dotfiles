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
import System.IO.Unsafe
import System.Posix.Unistd

import Data.Ratio ((%))
import Data.List

import qualified Data.Map as M
-- ******* Old Imports line by line. Remove or add back in as necessary. *****

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
    myHost <- fmap nodeName getSystemID   --Get the hostname of the machine
--    cnky <- spawnPipe "/usr/bin/conky -c /home/trev/.conkyLeftrc"
    xmproc <- spawnPipe "/usr/bin/xmobar "
    workspaceBar <- spawnPipe myWorkspaceBar
    replace
    xmonad $ defaultConfig
        { manageHook = myManageHook <+> manageDocks 
        , layoutHook = myLayoutHook  -- $  layoutHook defaultConfig
        , logHook = xmobarLog xmproc --myLogHook workspaceBar
        , modMask = mod4Mask     -- Rebind Mod to the Super key
        , terminal = "urxvtc"    -- Use urxvt clients
        , workspaces =  myWorkSpaces
        , keys=myKeys myHost
        }
-- Setup workspaces using short names to save display room        
myWorkSpaces=["term","web","code","ppl","fm","doc","vm","media","stch","scratch"]

xmobarLog xmproc = dynamicLogWithPP $ xmobarPP
                      { ppOutput = hPutStrLn xmproc
                      , ppTitle = xmobarColor "green" "" . shorten 50
                      }

myWorkspaceBar = "/usr/bin/dzen2 -x '0' -y '0' -h 16 -w '870' -ta '1' -fg "++ colorWhiteAlt  ++ " -bg " ++ colorBlack ++ " -fn "++dzenFont ++ "' -p -e ''"        
                         
dzenFont = "-*-montecarlo-medium-r-normal-*-11-*-*-*-*-*-*-*"
colorBlack = "#020202"
colorWhiteAlt = "#9d9d9d"
colorGray = "#444444"
colorGreen = "#99cc66"

-- Layout
myLayoutHook = avoidStruts  
          $ onWorkspace "term" (myGrid ||| simpleTabbed ||| Full) 
          $ onWorkspace "code" (myGrid ||| simpleTabbed ||| Full) 
          $ onWorkspace "ppl" (named "IM" (reflectHoriz $ withIM (1%5) (Title "Buddy List") (reflectHoriz $ myGrid ||| tall)))  
          $ onWorkspace "web" (simpleTabbed ||| Full ||| tall) 
          $ (tall ||| myGrid ||| Full ||| simpleTabbed )
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
   myFloats =["Gimp","Skype"]

-- Union default and new key bindings
myKeys hostname x  = M.union (M.fromList (newKeys hostname x)) (keys defaultConfig x)


-- Add new and/or redefine key bindings
newKeys hostname conf@(XConfig {XMonad.modMask = modMask}) = [
  (( modMask .|. controlMask, xK_e), spawn "eject -T")               --Keyboard shortcut for eject, usefull on slot load
 , ((modMask .|. controlMask, xK_Right), nextScreen)               --Move around screens
 , ((modMask .|. controlMask, xK_Left),  prevScreen)
 , ((modMask, xK_Tab), cycleRecentWS [xK_Control_R] xK_Left xK_Right )
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
 if( hostname =="charmy")    --Unsafe IO, but if laptop hostname then set specific keybindings
   then [ 
   ((0, 0x1008ff13), spawn "amixer set Master 2dB+") 
 , ((0,0x1008ff11), spawn "amixer set Master 2dB-")  
 ]
   else [ ]                                 -- If not laptop then no additional keybindings

myLogHook h = dynamicLogWithPP $ defaultPP
        { ppOutput          = hPutStrLn h
        , ppUrgent          = dzenColor colorGreen    colorBlack . pad . wrapClickWorkSpace . (\a -> (a,a))
        , ppHidden          = dzenColor colorGray     colorBlack . pad . wrapClickWorkSpace . (\a -> (a,a))
        , ppVisible         = dzenColor colorWhiteAlt colorBlack . pad . wrapClickWorkSpace . (\a -> (a,a))
        , ppHiddenNoWindows = dzenColor colorGray     colorBlack . pad . wrapClickWorkSpace . (\a -> (a,a))
        }
        where
            wrapClickLayout content = "^ca(1,xdotool key super+j)" ++ content ++ "^ca()"
            wrapClickWorkSpace (idx,str) = "^ca(1," ++ xdo "w;" ++xdo index ++ ")" ++ "^ca(3,"++ xdo "e;" ++xdo index ++ ")" ++ str ++ "^ca()^ca()"
              where
                  index = wsIdxToString (elemIndex idx myWorkSpaces)
                  wsIdxToString Nothing = "1"
                  wsIdxToString (Just n) = show (n+1)
                  xdo key = "xdotool key super+" ++ key
                
