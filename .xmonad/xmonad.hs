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
    myHost <- fmap nodeName getSystemID                                     --Get the hostname of the machine
    xmproc <- spawnPipe "/usr/bin/xmobar "                                  --Spawn xmobar
--    workspaceBar <- spawnPipe myWorkspaceBar                                --Spawn dzen
    replace
    uid <- getRealUserID
    name <- getUserEntryForID uid
    return $  usrName name
    xmonad $ defaultConfig
        { manageHook = myManageHook <+> manageDocks
        , layoutHook = myLayoutHook
        , logHook = xmobarLog xmproc --myLogHook workspaceBar
        , modMask = mod4Mask                                                --Rebind Mod to the Super key
        , terminal = "urxvtc"                                               --Use urxvt clients
        , workspaces =  myWorkSpaces                                        --Custom workspaces
        , keys=myKeys myHost                                                --Keybindings
        }
-- Setup workspaces using short names to save display room
myWorkSpaces=["term","web","code","ppl","fm","doc","vm","media","stch","scratch"]

altMask = mod1Mask

{- xmobar pretty printing log
 - Match xmobarColor from .xmobarrc
-}

xmobarLog xmproc = dynamicLogWithPP $ xmobarPP
                      { ppOutput = hPutStrLn xmproc
                      , ppTitle = xmobarColor "#1F66FF" "" . shorten 50
                      }

usrName :: UserEntry -> String
usrName (UserEntry x _ _ _ _ _ _) = x


-- Layout
myLayoutHook = avoidStruts
          $ onWorkspace "term" (myGrid ||| simpleTabbed ||| Full)
          $ onWorkspace "code" (myGrid ||| simpleTabbed ||| Full)
          $ onWorkspace "ppl" (named "IM" (reflectHoriz $ withIM (1%5) (Title "Buddy List") (reflectHoriz $ myGrid ||| tall)))
          $ onWorkspace "web" (simpleTabbed ||| Full ||| tall)
          $ (myGrid ||| simpleTabbed )
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
     , [(className =? "Firefox" <&&> resource =? "Dialog") --> doFloat]     --Float Firefox Dialogs
   ])
   where
   myWebShift = ["Firefox","Chromium","Iceweasel","luakit", "Conkeror"]
   myImShift = ["Pidgin","Skype"]
   myDocShift = ["libreoffice-impress","libreoffice-writer","libreoffice-startcenter","Libreoffice","xpdf","Evince","Texmaker","Mirage","LibreOffice Calc"]
   myMediaShift = ["Banshee","Vlc","Rhythmbox","xine","Spotify","Steam"]
   myFloats =["Gimp","Skype"]

{- Keybinding section
 - Union defaults
 - list new keybindings
 - Special keybindings by hostname
-}

-- Union default and new key bindings
myKeys hostname x  = M.union (M.fromList (newKeys hostname x)) (keys defaultConfig x)


-- Add new and/or redefine key bindings
newKeys hostname conf@(XConfig {XMonad.modMask = modMask}) = [
  (( modMask .|. controlMask, xK_e), spawn "eject -T")                      --Keyboard shortcut for ejecting cd
 , ((modMask .|. controlMask, xK_Down), shiftToNext)                        --Move around screens
 , ((modMask .|. controlMask, xK_Up), shiftToPrev)                          --Move around screens
 , ((modMask .|. controlMask, xK_Right), nextScreen)                        --Move around screens
 , ((modMask .|. controlMask, xK_Left),  prevScreen)
 , ((modMask, xK_equal), nextWS)                                            --Cycle through WorkSpaces
 , ((modMask, xK_minus), prevWS)
 , ((modMask .|. shiftMask, xK_Right), shiftNextScreen)                     --Move things around screens
 , ((modMask .|. shiftMask, xK_Left), shiftPrevScreen)
-- Add shortcuts for programs
 , ((modMask .|. shiftMask, xK_a), spawn "emacs")
 , ((modMask .|. shiftMask, xK_c), spawn "conkeror")
 , ((modMask .|. shiftMask, xK_e), spawn "evince")
 , ((modMask .|. shiftMask, xK_f), spawn "Firefox")
 , ((modMask .|. shiftMask, xK_g), spawn "steam")
 , ((modMask .|. shiftMask, xK_h), spawn "chromium")
 , ((modMask .|. shiftMask, xK_k), spawn "texmaker")
 , ((modMask .|. shiftMask, xK_l), spawn "luakit")
 , ((modMask .|. shiftMask, xK_m), spawn "mirage")
 , ((modMask .|. shiftMask, xK_n), spawn "xine")
 , ((modMask .|. shiftMask, xK_p), spawn "pidgin")
 , ((modMask .|. shiftMask, xK_r), spawn "rhythmbox")
 , ((modMask .|. shiftMask, xK_s), spawn "spotify")
 , ((modMask .|. shiftMask, xK_t), spawn "thunar")
 , ((modMask .|. shiftMask, xK_v), spawn "virtualbox")
-- , ((modMask .|. shiftMask, xK_z), spawn "zsnes")
 , ((modMask .|. shiftMask .|. controlMask, xK_End), spawn "sudo pm-suspend")
 , ((modMask .|. controlMask, xK_t), spawn "urxvt")
 ]

 ++
 if( hostname =="charmy")                                                   --if laptop hostname set specific keybindings
   then [
   ((0, 0x1008ff13), spawn "amixer set Master 2dB+")
 , ((0,0x1008ff11), spawn "amixer set Master 2dB-")
 ]
   else [ ]                                                                 --Otherwise nothing


{- Dzen section
 -
 - Different loghook
 - Custom workspace bar
 - Additional colors
-}

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

myWorkspaceBar = "/usr/bin/dzen2 -x '0' -y '0' -h 16 -w '870' -ta '1' -fg "++ colorWhiteAlt  ++ " -bg " ++ colorBlack ++ " -fn "++dzenFont ++ "' -p -e ''"

dzenFont = "-*-montecarlo-medium-r-normal-*-9-*-*-*-*-*-*-*"
colorBlack = "#020202"
colorWhiteAlt = "#9d9d9d"
colorGray = "#444444"
colorGreen = "#99cc66"

-- xmobar configuration on per host basis
--

colorPosition = " -f \"-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*\" -B #303030 -F grey"

xmobarCommands = " -c '[ Run Weather \"KPDK\" \"-t\",\"<station>:<tempF>F\",\"-L\",\"35\",\"-H\",\"85\" ,\"--normal\",\"green\",\"--high\",\"red\",\"-- ,\"#1F66FF\"] 18000 , Run Network \"eth0\" [\"-L\",\"0\",\"-H\",\"32\",\"--normal\" ,\"#1F66FF\",\"--high\",\"red\"] 10 , Run Cpu [\"-L\",\"3\",\"-H\",\"50\",\"--normal\",\"#1F66FF\" ,\"--high\",\"red\"] 10 , Run Memory [\"-t\",\"Mem: <usedratio>%\"] 10 , Run Swap [] 10 , Run Date \"%a %b %_d %Y %H:%M:%S\" \"date\" 10 , Run StdinReader"

xmobarPick host =
  if (host == "charmy")
    then
      colorPosition ++ xmobarCommands ++ ", Run Network \"wlan0\" [\"-L\",\"0\",\"-H\",\"32\",\"--normal\",\"#1FF66FF\",\"--high\",\"red\"] 10 , Run BatteryP[\"BAT0\"][\"--\", \"-c\", \"energy_full\"] 10 ]'" ++ " -s\"%\" -a \"}{\" "++ "-t \" %cpu% | %memory% | %battery% | %eth0% %wlan0% | %StdinReader%}{ <fc=#ee9a00>%date%</fc>| %KPDK%\" position = TopSize R 90 20"
      else
        colorPosition++xmobarCommands++"]'"++ " -s \"%\" -a \"}{\" "++ " -t \" %cpu% | %memory% | %eth0% | %StdinReader%}{ <fc=#ee9a00>%date%</fc>| %KPDK%\" position= TopSize R 90 20"
