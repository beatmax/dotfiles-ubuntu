import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig

myManagementHooks = [
  className =? "Gimp"      --> doFloat
  , className =? "Vncviewer" --> doFloat
  ]

main = do
  xmonad $ ewmh xfceConfig
      {
        handleEventHook = handleEventHook xfceConfig
          <+> fullscreenEventHook
      , manageHook = manageHook xfceConfig
          <+> composeAll myManagementHooks
      , terminal = "xfce4-terminal --hide-menubar --hide-scrollbar"
      } `removeKeys`
      [
        (mod1Mask, xK_b)
      ] `additionalKeys`
      [
        ((mod1Mask .|. shiftMask, xK_b), sendMessage ToggleStruts)
      , ((mod1Mask .|. shiftMask, xK_l), spawn "slock")
      ]
