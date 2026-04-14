class Kyber < Formula
  desc "Source-agnostic life management execution platform"
  homepage "https://github.com/IanGordonOne/kyber"
  version "0.9.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/IanGordonOne/kyber/releases/download/v0.9.1/kyber-0.9.1-darwin-arm64.tar.gz"
      sha256 "435c751b4824a8b6c28fb55d3f589cd56500d8741d3e80734a9bf4d2f1c896c7"
    end
    on_intel do
      url "https://github.com/IanGordonOne/kyber/releases/download/v0.9.1/kyber-0.9.1-darwin-amd64.tar.gz"
      sha256 "c5e797d3b048e2e67ca575a4897ce6f90e4fa901a96bc03986ebb541e530aa9f"
    end
  end

  def install
    bin.install "kyber"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kyber --version")
  end
end
