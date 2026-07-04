# Template for the Suniye Homebrew Cask.
#
# This is the single source of truth for the cask. It is rendered by
# scripts/update_homebrew_tap.sh (which fills in the version and sha256) and
# pushed to the kishanhitk/homebrew-tap repository as Casks/suniye.rb on every
# stable release. Do not edit the rendered file in the tap directly.
cask "suniye" do
  version "0.0.47"
  sha256 "60d8cda355a37df627841fb05b1df199b7de21c8d7d0e402365b93135f928f72"

  url "https://github.com/kishanhitk/suniye/releases/download/v#{version}/Suniye.dmg",
      verified: "github.com/kishanhitk/suniye/"
  name "Suniye"
  desc "Private, on-device push-to-talk dictation"
  homepage "https://suniye.kishans.in/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Suniye.app"

  # Suniye is self-signed but not notarized. Homebrew quarantines downloads, which
  # trips Gatekeeper on first launch, so strip the quarantine attribute here. This
  # mirrors the manual `xattr -dr com.apple.quarantine` step documented for the DMG.
  # (Allowed in a personal tap; official homebrew-cask audit would reject it.)
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-d", "-r", "com.apple.quarantine", "#{appdir}/Suniye.app"],
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/Suniye",
    "~/Library/Caches/dev.suniye.app",
    "~/Library/HTTPStorages/dev.suniye.app",
    "~/Library/Preferences/dev.suniye.app.plist",
    "~/Library/Saved Application State/dev.suniye.app.savedState",
  ]
end
