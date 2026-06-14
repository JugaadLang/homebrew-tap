class Jugaadlang < Formula
  desc "Hindi-keyword programming language for Indian developers"
  homepage "https://jugaadlang.netlify.app"
  url "https://github.com/jugaadlang/jugaadlang/archive/refs/tags/v1.1.5.tar.gz"
  sha256 "935dcaa0cd0edfe270ac6cceb3db80e5ba6f4725c6dc9f898e045a45cb5cd25c"
  license "MIT"

  bottle do
    root_url "https://github.com/JugaadLang/homebrew-tap/releases/download/jugaadlang-1.1.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6b45f4b1e31c49adcb967cf12aa0f30774fe4b63b2262ab7cc4fb1b41e8a9e07"
    sha256 cellar: :any_skip_relocation, sequoia:      "0a29b834d769d4f9079649ecc116b431b8d8d6c9c8202a3f0a3cb1553ea86ae9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "47fb1c250a6727ccf95c75a189c5cb5fa24cafa09838c0d4e52feea33e96fc81"
  end

  depends_on "python@3.12"

  def install
    # Remove 'publish' from dependencies since it's a dev tool and causes linkage issues
    inreplace "pyproject.toml", /"publish>=.*",?/, ""

    # Create a virtual environment in libexec
    system "python3.12", "-m", "venv", libexec

    # Install the package and its dependencies via pip
    system libexec/"bin/pip", "install", "-v", "--ignore-installed", buildpath

    # Symlink the executable into bin
    bin.install_symlink libexec/"bin/jug"
  end

  test do
    # Simple test to verify the jug binary is available
    system "#{bin}/jug", "--version"
  end
end
