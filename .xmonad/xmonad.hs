import qualified Data.Map as M
import           Data.Monoid (Endo)
import           Data.Ratio ((%))
import           GHC.IO.Handle.Types (Handle)
import           Graphics.X11.ExtraTypes.XF86 (xF86XK_MonBrightnessDown,
                                               xF86XK_MonBrightnessUp)
import Network.BSD (getHostName)
import           System.Posix.Unistd (getSystemID, nodeName)
import           System.Posix.User            (getRealUserID,
                                               getUserEntryForID)
import           XMonad                       (Full (..), KeyMask, KeySym,
                                               Layout, LayoutClass, Mirror (..),
                                               Query, ScreenDetail, ScreenId,
                                               Tall (..), Window, X,
                                               XConfig (..), controlMask, keys,
                                               layoutHook, logHook, manageHook,
                                               mod1Mask, mod4Mask, modMask,
                                               shiftMask, spawn, startupHook,
                                               terminal, windows, workspaces,
                                               xK_0, xK_Down, xK_Left, xK_Right,
                                               xK_Up, xK_b, xK_c, xK_e,
                                               xK_equal, xK_f, xK_g, xK_l, xK_minus,
                                               xK_p, xK_r, xK_h,xK_n, xK_s, xK_t, xK_v, xK_x,
                                                xmonad, (.|.), (|||), xK_z, xK_m)
import           XMonad.Actions.CycleWS       (nextScreen, nextWS, prevScreen,
                                               prevWS, shiftNextScreen,
                                               shiftPrevScreen, shiftToNext,
                                               shiftToPrev)
import XMonad.Actions.GridSelect
--import XMonad.Actions.Volume
import           XMonad.Hooks.DynamicLog      (def, dynamicLogWithPP, dzenColor,
                                               pad, ppCurrent, ppHidden,
                                               ppHiddenNoWindows, ppOrder,
                                               ppOutput, ppVisible, ppWsSep)
import           XMonad.Hooks.EwmhDesktops (ewmh)
import           XMonad.Hooks.ManageDocks     (AvoidStruts, avoidStruts, docks,
                                               docksStartupHook, manageDocks)
import           XMonad.Layout (Choose)
import           XMonad.Layout.Dishes (Dishes(Dishes))
import           XMonad.Layout.GridVariants (TallGrid (..), Grid(..))
import           XMonad.Layout.IM             (AddRoster, Property (Title),
                                               withIM)
import           XMonad.Layout.LayoutModifier (ModifiedLayout)
import           XMonad.Layout.PerWorkspace (PerWorkspace, onWorkspace)
import           XMonad.Layout.Reflect (Reflect, reflectHoriz)
import           XMonad.Layout.Renamed (Rename, named)
import           XMonad.ManageHook            (className, composeAll, doF,
                                               doFloat, resource, (-->), (<&&>),
                                               (<+>), (=?))
import           XMonad.Prompt (greenXPConfig)
import           XMonad.Prompt.Shell (shellPrompt, prompt)
import qualified XMonad.StackSet as W
--import           XMonad.Util.Hacks
import           XMonad.Util.Replace (replace)
import           XMonad.Util.Run (hPutStrLn, spawnPipe)

main :: IO ()
main = do
    myHost <- getHostName
    replace
    uid <- getRealUserID
    name <- getUserEntryForID uid
    leftBar <- spawnPipe "nezd -x '12%' -h '4%' -w '50%' -ta 'l' -fn xft:Hack:size=12:antialias=true -dock"
--    _ <- pure $ usrName name
    xmonad . docks $ ewmh def
        { manageHook  = myManageHook <+> manageDocks
        , layoutHook  = myLayoutHook
        , logHook     = dzenLog leftBar
        , modMask     = mod4Mask --Rebind Mod to the Super key
        , terminal    = myTerm myHost
        , workspaces  = myWorkSpaces --Custom workspaces
        , keys        = myKeys myHost --Keybindings
--        , startupHook = docksStartupHook
        }

-- Setup workspaces using short names to save display room
myWorkSpaces :: [String]
myWorkSpaces =
  ["web","term","editor","work1","work2","mail","media","read","im","vm","ex"]

-- On hosts where resources are more constrained use urxvt in daemon mode instead of alarcitty
myTerm :: String -> String
myTerm "zero" = "urxvtcd"
myTerm "magmadragoon" = "urxvtcd"
myTerm "double" = "urxvt"
myTerm _ = "alacritty"

altMask :: KeyMask
altMask = mod1Mask

-- Get username
-- usrName :: UserEntry -> String
-- usrName (UserEntry x _ _ _ _ _ _) = x

-- Layout
-- The type signature is quite a bit to ingest, thus omitted, but looking at the code it should make sense..
myLayoutHook =
  avoidStruts
  $ onWorkspace "web" (Full ||| Mirror myGrid ||| tall ||| myGrid ||| myDishes)
  $ onWorkspace "term" (myGrid ||| Mirror myGrid ||| Full ||| tall ||| myDishes)
  $ onWorkspace "editor" (Mirror myGrid ||| myGrid ||| Full ||| tall ||| myDishes)
  (myGrid ||| Mirror myGrid ||| Full ||| tall ||| myDishes)
  where
    tall = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1/2
    delta = 4/100
    defaultRatio = 1/2
    myDishes = Dishes 2 (1/8)
    myGrid = Grid (16/9) -- might as well match most screen ratios here... *sigh*

-- Move some programs to certain workspaces and float some too
myManageHook :: Query (Endo (W.StackSet String (Layout Window) Window ScreenId ScreenDetail))
myManageHook = composeAll . concat $
    [ [className =? x --> doF (W.shift "web") | x <- myWebShift]
    , [className =? x --> doF (W.shift "im") | x <- myImShift]
    , [className =? x --> doF (W.shift "media") | x <- myMediaShift]
    , [className =? x --> doF (W.shift "read") | x <- myReadShift]
    , [className =? x --> doF (W.shift "mail") | x <- myMailShift]
    , [className =? x --> doF (W.shift "vm") | x <- vmShift ]
    , [className =? x --> doFloat | x <- myFloats]
    , [(className =? "Firefox" <&&> resource =? "Dialog") --> doFloat] --Float Firefox Dialogs
    ]
  where
    myWebShift = ["chromium","Chromium","Chromium-browser", "Conkeror","Firefox", "Firefox-esr", "luakit"]
    myImShift = ["Pidgin","Skype","Slack", "Signal"]
    myReadShift = ["calibre","Calibre","evince","Evince","Mirage","Texmaker","xpdf"]
    myMediaShift = ["Banshee","Rhythmbox","spotify","Spotify","Steam","Vlc","xine"]
    myMailShift = ["Evolution","Thunderbird"]
    vmShift = ["virt-manager", "Virt-manager", "VirtualBox"]
    myFloats = ["Gimp","Inkscape","Remmina","Skype"]

{- Keybinding section
 - Union defaults
 - list new keybindings
 - Special keybindings by hostname
-}

-- Union default and new key bindings
myKeys :: String -> XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys hostname x  = M.union (M.fromList (newKeys hostname x)) (keys def x)

-- Add new and/or redefine key bindings
newKeys :: String -> XConfig l -> [((KeyMask, KeySym), X ())]
newKeys hostname conf@XConfig {XMonad.modMask = modMask} =
  [ ((modMask .|. controlMask, xK_r), spawn "xrandr --output VGA-0 --auto") -- Resize vbox screen
  , ((modMask .|. controlMask, xK_s), spawn "scrot -s")
  , ((modMask, xK_f), spawn "flameshot")
  , ((modMask .|. controlMask, xK_x), shellPrompt greenXPConfig)
  , ((modMask .|. controlMask, xK_g), goToSelected def)
  , ((modMask .|. controlMask, xK_h), gridselectWorkspace def W.greedyView)
--  , ((modMask .|. controlMask, xK_z), toggleMute >> pure ())
  , ((modMask .|. controlMask, xK_Down), shiftToNext) --Move around screens
  , ((modMask .|. controlMask, xK_Up), shiftToPrev) --Move around screens
  , ((modMask .|. controlMask, xK_Right), nextScreen) --Move around screens
  , ((modMask .|. controlMask, xK_Left),  prevScreen)
  , ((modMask, xK_equal), nextWS) --Cycle through WorkSpaces
  , ((modMask, xK_minus), prevWS)
  , ((modMask .|. shiftMask, xK_Right), shiftNextScreen) --Move things around screens
  , ((modMask .|. shiftMask, xK_Left), shiftPrevScreen) -- Add shortcuts for programs
  , ((modMask .|. shiftMask, xK_b), spawn "calibre")
  , ((modMask .|. shiftMask, xK_e), spawn "emacs")
  , ((modMask .|. shiftMask, xK_f), spawn "firefox")
  , ((modMask .|. shiftMask, xK_g), spawn "chromium")
  , ((modMask .|. shiftMask, xK_l), spawn "slack")
--  , ((modMask .|. shiftMask, xK_m), spawn "toggle-mute-master")
  , ((modMask .|. shiftMask, xK_p), spawn "pidgin")
  , ((modMask .|. shiftMask, xK_r), spawn "rhythmbox")
  , ((modMask .|. shiftMask, xK_s), spawn "spotify")
  , ((modMask .|. shiftMask, xK_t), spawn "thunderbird")
  , ((modMask .|. shiftMask, xK_v), spawn "calibre")
  , ((modMask, xK_0), windows $ W.greedyView $ myWorkSpaces!!9)
--  , ((0,0x1008ff12), toggleMute >> return ())
 -- , ((modMask .|. shiftMask .|. controlMask, xK_End), spawn "sudo pm-suspend")
  ]

-- host specific stuff, saved here to remember how to do it later :P
  -- ++
  -- if hostname == "charmy" --if laptop hostname set specific keybindings
  -- then [ ((0, 0x1008ff13), spawn "amixer set Master 2dB+")
  --      , ((0,0x1008ff11), spawn "amixer set Master 2dB-")
  --      ]

dzenLog :: Handle -> X ()
dzenLog out =
  dynamicLogWithPP
   (def
    { ppCurrent         = dzenColor "#FF8800" "#000000"
    , ppVisible         = dzenColor "#EAEAEA" "#000000" . pad
    , ppHidden          = dzenColor "#777777" "#000000"
    , ppHiddenNoWindows = dzenColor "#333333" "#000000"
    , ppWsSep           = " "
    , ppOrder           = \(workspace:currentLayout:focusedWindow:_) -> [workspace, currentLayout, focusedWindow]
    , ppOutput          = hPutStrLn out
    })
