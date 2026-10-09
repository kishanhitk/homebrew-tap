# Template for the Suniye Homebrew Cask.
#
# This is the single source of truth for the cask. It is rendered by
# scripts/update_homebrew_tap.sh (which fills in the version and sha256) and
# pushed to the kishanhitk/homebrew-tap repository as Casks/suniye.rb on every
# stable release. Do not edit the rendered file in the tap directly.
cask "suniye" do
  version "0.0.71"
  sha256 "741705e82d5a750a26a4eda132053ee9da3450514208b2a9f5a0c6906908f432"

  url "https://github.com/kishanhitk/suniye/releases/download/v#{version}/Suniye.dmg",
      verified: "github.com/kishanhitk/suniye/"
  name "Suniye"
  desc "Private, on-device push-to-talk dictation"
  homepage "https://suniye.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Suniye.app"

  zap trash: [
    "~/Library/Application Support/Suniye",
    "~/Library/Caches/dev.suniye.app",
    "~/Library/HTTPStorages/dev.suniye.app",
    "~/Library/Preferences/dev.suniye.app.plist",
    "~/Library/Saved Application State/dev.suniye.app.savedState",
  ]
end
