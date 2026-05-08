class Vigia < Formula
  desc "AFK gatekeeper + autonomous-agent runner for bd-tracked repos"
  homepage "https://github.com/IanGordonOne/vigia"
  url "https://github.com/IanGordonOne/vigia.git",
      using:  :git,
      branch: "main"
  version "0.1.0"
  license "MIT"

  depends_on "bd"
  depends_on "fswatch" => :recommended
  depends_on "jq"
  depends_on "python@3.13"

  def install
    # Real scripts live in libexec/{bin,share}; we exec into them via thin
    # wrappers in bin/ that set VIGIA_SHARE_DIR. Keeps Homebrew's bin/ tidy
    # while preserving the dev layout where bin/../share lives next door.
    (libexec/"bin").install Dir["bin/*"]
    (libexec/"share").install Dir["share/*"]
    pkgshare.install "examples", "docs"
    pkgshare.install "tests"

    # Wrappers in bin/ — symlinked into PREFIX/bin by Homebrew's link phase.
    Dir["#{libexec}/bin/*"].each do |target|
      name = File.basename(target)
      (bin/name).write <<~SHIM
        #!/bin/bash
        export VIGIA_SHARE_DIR="#{libexec}/share"
        exec "#{libexec}/bin/#{name}" "$@"
      SHIM
      (bin/name).chmod 0755
    end
  end

  def caveats
    <<~EOS
      vigía is a gatekeeper + agent-runner for bd-tracked repos. To adopt in
      a consuming repo:

        1. Add a config at .beads/afk-config.yaml (see #{opt_pkgshare}/examples/
           for Go and TypeScript flavors).
        2. Optionally copy #{opt_pkgshare}/examples/policy.example.yaml to
           .beads/afk-policy.yaml and customize.
        3. Update CLAUDE.md with the AFK rules (see vigía's docs/AFK-GATEKEEPER.md).
        4. Run `afk-eval --bootstrap` from the repo root to verify.

      Optional watch daemon (re-evaluates on bd writes via fswatch):

        cd /path/to/your-repo
        install-afk-watch              # idempotent install + load
        install-afk-watch --uninstall  # tear down

      See #{opt_pkgshare}/docs/AFK-GATEKEEPER.md for the full ops doc.
    EOS
  end

  test do
    # Smoke: --help should not crash, version line should print.
    assert_match "afk-eval", shell_output("#{bin}/afk-eval --help 2>&1", 2)
    assert_match "afk-pick", shell_output("#{bin}/afk-pick --help 2>&1", 2)
  end
end
