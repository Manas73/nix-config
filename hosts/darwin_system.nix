{ pkgs, ... }:

{
    security.pam.enableSudoTouchIdAuth = true;
    system = {
        defaults = {
          NSGlobalDomain = {
            AppleInterfaceStyle = "Dark";
            AppleInterfaceStyleSwitchesAutomatically = false;
            AppleShowAllExtensions = true;
            NSAutomaticCapitalizationEnabled = false;
            NSAutomaticSpellingCorrectionEnabled = false;
            "com.apple.mouse.tapBehavior" = 1;
            "com.apple.trackpad.enableSecondaryClick" = true;
            # "com.apple.keyboard.fnState" = true;
          };
          dock = {
            autohide = false;
            magnification = true;
            # magnification size
            largesize = 95;
            mineffect = "scale";
            # minimize-to-application = true;
            orientation = "bottom";
            showhidden = false;
            show-recents = false;
            tilesize = 64;
          };
          finder = {
            ShowPathbar = true;
            ShowStatusBar = true;
          };
          trackpad = {
            Clicking = true;
            TrackpadRightClick = true;
          };

          CustomUserPreferences = {
            # Settings of plist in ~/Library/Preferences/
            "com.apple.finder" = {
              # Set home directory as startup window
              NewWindowTarget = "PfHm";
              # Set search scope to directory
              FXDefaultSearchScope = "SCcf";
              # Multi-file tab view
              FinderSpawnTab = true;
            };
            "com.apple.desktopservices" = {
              # Disable creating .DS_Store files in network an USB volumes
              DSDontWriteNetworkStores = true;
              DSDontWriteUSBStores = true;
            };
            # Show battery percentage
            "~/Library/Preferences/ByHost/com.apple.controlcenter".BatteryShowPercentage = true;
            # Privacy
            "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
          };
          WindowManager = {
            EnableStandardClickToShowDesktop = false;
          };
        };
    };
}