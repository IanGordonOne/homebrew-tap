class Kyber < Formula
  desc "Source-agnostic life management execution platform"
  homepage "https://github.com/IanGordonOne/kyber"
  version "0.9.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/IanGordonOne/kyber/releases/download/v0.9.2/kyber-0.9.2-darwin-arm64.tar.gz"
      sha256 "594814e4228378c194ac6e0f060c857e12f601cdb29f8e3e7ea85386973146c4"
    end
    on_intel do
      url "https://github.com/IanGordonOne/kyber/releases/download/v0.9.2/kyber-0.9.2-darwin-amd64.tar.gz"
      sha256 "4becde6ba550716e81065ba99618648dfb008d61cc466105a963b62f407492af"
    end
  end

  def install
    bin.install "kyber"
    # kyber-3o5: strip macOS download quarantine so the
    # binary is not killed by Gatekeeper / amfid on first
    # run. Pre-Homebrew workaround required xattr -d by
    # hand; brew install now handles it.
    system "/usr/bin/xattr", "-d", "com.apple.quarantine", bin/"kyber" rescue nil
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kyber --version")
  end
end
