class Kyber < Formula
  desc "Source-agnostic life management execution platform"
  homepage "https://github.com/IanGordonOne/kyber"
  version "0.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://api.github.com/repos/IanGordonOne/kyber/releases/assets/368524841",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "fa304ac2b6bdd84eda1e0317d0a3156256b6d03dad81d5f49a3e591f3c0775e1"
    end
    on_intel do
      url "https://api.github.com/repos/IanGordonOne/kyber/releases/assets/368524838",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "862239a8830b8dd7731f5bd2700a3198993762c3d0f089d7efc9ba3e3feffe86"
    end
  end

  def install
    bin.install "kyber"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kyber --version")
  end
end
