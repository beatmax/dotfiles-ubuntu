import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W

myManagementHooks = [
  className =? "Gimp"      --> doFloat
  , className =? "Vncviewer" --> doFloat
  ]

myModMask = mod1Mask

myWorkspaces = map show [1..9] ++ ["0"]

main = do
  xmonad $ ewmhFullscreen xfceConfig
      {
        handleEventHook = handleEventHook xfceConfig
      , layoutHook = smartSpacing 4 $ layoutHook xfceConfig
      , manageHook = manageHook xfceConfig
          <+> composeAll myManagementHooks
      , terminal = "xfce4-terminal --hide-menubar --hide-scrollbar"
      , borderWidth = 2
      , normalBorderColor = "#584a56"
      , focusedBorderColor = "#9b71d7"
      , modMask = myModMask
      , workspaces = myWorkspaces
      } `removeKeys`
      [
        (myModMask, xK_b)
      ] `additionalKeys`
      [
        ((myModMask .|. shiftMask, xK_b), sendMessage ToggleStruts)
      , ((myModMask .|. shiftMask, xK_l), spawn "slock")
      , ((myModMask, xK_0), windows $ W.greedyView "0")
      , ((myModMask .|. shiftMask, xK_0), windows $ W.shift "0")
      ]
