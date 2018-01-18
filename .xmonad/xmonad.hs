import Data.List
import qualified Data.Map as M
import Data.Ratio ((%))

import System.Posix.Unistd
import System.Posix.User

import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Actions.CycleRecentWS
import XMonad.Actions.CycleWS
import XMonad.Core
import XMonad.Hooks.DynamicHooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout
import XMonad.Layout.GridVariants         --for Grids
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed       -- for simpleTabbed
import XMonad.ManageHook
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.Replace
import XMonad.Actions.SwapWorkspaces

main = do
    myHost <- fmap nodeName getSystemID                                     --Get the hostname of the machine
    replace
    uid <- getRealUserID
    name <- getUserEntryForID uid
    leftBar <- spawnPipe "dzen2 -x '380' -h '77' -w '1030' -ta 'l' "
    --xmproc <- spawnPipe $ ("`which xmobar`" ++ (xmobarPick) ++ "~/.xmobarrc")
    _ <- return $ usrName name
    xmonad $ ewmh def
        { manageHook = myManageHook <+> manageDocks
        , layoutHook = myLayoutHook
        , logHook = dzenLog leftBar
--        , logHook = xmobarLog xmproc
        , modMask = mod4Mask                                                --Rebind Mod to the Super key
        , terminal = myTerm                                          --Use urxvt clients
        , workspaces =  myWorkSpaces                                        --Custom workspaces
        , keys=myKeys myHost                                                --Keybindings
        , startupHook = docksStartupHook
        }

-- Setup workspaces using short names to save display room
myWorkSpaces :: [String]
myWorkSpaces = ["web","term","editor","work1","work2","mail","media","read","im","vm","ex"]

myTerm :: String
myTerm = "xterm"

altMask :: KeyMask
altMask = mod1Mask

-- Get username
usrName :: UserEntry -> String
usrName (UserEntry x _ _ _ _ _ _) = x

-- Layout
myLayoutHook = avoidStruts
          $ onWorkspace "web" (Full ||| Mirror myGrid ||| tall)
          $ onWorkspace "term" (myGrid ||| Mirror myGrid ||| Full)
          $ onWorkspace "editor" (Mirror myGrid ||| myGrid ||| Full)
          $ onWorkspace "im" (named "IM" (reflectHoriz $ withIM (1%5) (Title "Buddy List") (reflectHoriz $ Mirror myGrid ||| tall ||| Full)))
          $ (myGrid ||| Mirror myGrid ||| Full ||| tall)
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
     , [className =? x --> doF (W.shift "read") | x <- myReadShift]
     , [className =? x --> doF (W.shift "mail") | x <- myMailShift]
     , [className =? "VirtualBox"      --> doF (W.shift "vm")]
     , [className =? x --> doFloat | x <- myFloats]
     , [(className =? "Firefox" <&&> resource =? "Dialog") --> doFloat]     --Float Firefox Dialogs
   ])
   where
   myWebShift = ["Firefox","Chromium-browser","Iceweasel","luakit", "Conkeror"]
   myImShift = ["Pidgin","Skype","Slack"]
   myReadShift = ["xpdf","Evince","Texmaker","Mirage","Calibre","calibre","evince","Evince"]
   myMediaShift = ["Banshee","Vlc","Rhythmbox","xine","Spotify","Steam","spotify"]
   myMailShift = ["Thunderbird","Evolution"]
   myFloats = ["Gimp","Inkscape","Remmina","Skype","Slack"]

{- Keybinding section
 - Union defaults
 - list new keybindings
 - Special keybindings by hostname
-}

-- Union default and new key bindings
myKeys hostname x  = M.union (M.fromList (newKeys hostname x)) (keys def x)

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
 , ((modMask .|. shiftMask, xK_c), spawn "chromium-browser")
 , ((modMask .|. shiftMask, xK_e), spawn "emacs")
 , ((modMask .|. shiftMask, xK_f), spawn "firefox")
 , ((modMask .|. shiftMask, xK_l), spawn "slack")
 , ((modMask .|. shiftMask, xK_m), spawn "evolution")
 , ((modMask .|. shiftMask, xK_p), spawn "pidgin")
 , ((modMask .|. shiftMask, xK_r), spawn "rhythmbox")
 , ((modMask .|. shiftMask, xK_s), spawn "spotify")
 , ((modMask .|. shiftMask, xK_v), spawn "VirtualBox")
 , ((modMask, xK_0), windows $ W.greedyView $ myWorkSpaces!!9)
-- , ((modMask .|. shiftMask, xK_z), spawn "zsnes")
 -- , ((modMask .|. shiftMask .|. controlMask, xK_End), spawn "sudo pm-suspend")
 ]

 ++
 if( hostname == "charmy")                                                   --if laptop hostname set specific keybindings
   then [
   ((0, 0x1008ff13), spawn "amixer set Master 2dB+")
 , ((0,0x1008ff11), spawn "amixer set Master 2dB-")
 ]
   else [((0,xF86XK_MonBrightnessDown), spawn "xbacklight -dec 5")
        ,((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 5")
        ]                                                                 --Otherwise nothing

dzenLog out = dynamicLogWithPP (defaultPP
  { ppCurrent   = dzenColor "#FF8800" "#000000"
  , ppVisible   = dzenColor "#BABABA" "#000000" . pad
  , ppHidden    = dzenColor "#777777" "#000000"
  , ppHiddenNoWindows = dzenColor "#333333" "#000000"
  , ppWsSep   = " "
  , ppOrder =  \(ws:_:_:_) -> [ws]
  , ppOutput  =   hPutStrLn out
  } )

xmobarLog xmproc = dynamicLogWithPP $ xmobarPP
                       { ppOutput = hPutStrLn xmproc
                       , ppTitle = xmobarColor "#1F66FF" "" . shorten 50
                       }

xmobarPick :: String
xmobarPick = colorPosition ++ " -t \" %cpu% | %memory% | %dynnetwork% | %battery% | %StdinReader%}{ %date% \" "  ++ xmbrStdin ++ xmbrCpu ++ xmbrMem ++ xmbrNet ++ xmbrBat

colorPosition :: String
colorPosition = " -f xft:Hack:size=12:antialias=true -F gray"

xmbrNet :: String
xmbrNet = "-C '[Run DynNetwork [\"-L\",\"50\",\"-H\",\"20000\",\"-l\",\"lightblue\",\"-n\",\"green\",\"-h\",\"red\"] 10]' "

xmbrCpu :: String
xmbrCpu = "-C '[Run Cpu [\"-L\",\"5\",\"-H\",\"50\",\"--normal\",\"lightblue\" ,\"--high\",\"red\"] 10]' "

xmbrMem :: String
xmbrMem = "-C '[Run Memory [\"-t\",\"Mem: <usedratio>%\"] 10]' "

xmbrStdin :: String
xmbrStdin = "-C '[Run StdinReader]' "

xmbrBat :: String
xmbrBat = "-C '[Run BatteryP[\"BAT0\"][\"-t\",\"<acstatus>\",\"-L\",\"10\",\"-H\",\"80\",\"-l\",\"red\",\"-h\",\"green\",\"--\",\"-L\",\"-15\",\"-H\",\"-5\",\"-l\",\"red\",\"-m\",\"blue\",\"-h\",\"green\",\"-O\",\"Charging <timeleft>\",\"-i\",\"Charged\",\"-o\",\"Batt: <left>% / <timeleft>\"] 10 ]' "
