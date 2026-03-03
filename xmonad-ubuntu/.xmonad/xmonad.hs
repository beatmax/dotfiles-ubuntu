import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig

myManagementHooks = [
  className =? "Gimp"      --> doFloat
  , className =? "Vncviewer" --> doFloat
  ]

main = do
  xmonad $ ewmhFullscreen xfceConfig
      {
        handleEventHook = handleEventHook xfceConfig
      , layoutHook = smartSpacing 4 $ layoutHook xfceConfig
      , manageHook = manageHook xfceConfig
          <+> composeAll myManagementHooks
      , terminal = "xfce4-terminal --hide-menubar --hide-scrollbar"
      , borderWidth = 2
      , normalBorderColor = "#282a36"
      , focusedBorderColor = "#9b71d7"
      } `removeKeys`
      [
        (mod1Mask, xK_b)
      ] `additionalKeys`
      [
        ((mod1Mask .|. shiftMask, xK_b), sendMessage ToggleStruts)
      , ((mod1Mask .|. shiftMask, xK_l), spawn "slock")
      ]
