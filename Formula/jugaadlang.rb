class Jugaadlang < Formula
  desc "Hindi-keyword programming language for Indian developers"
  homepage "https://jugaadlang.netlify.app"
  url "https://github.com/jugaadlang/jugaadlang/archive/refs/tags/v1.1.5.tar.gz"
  sha256 "935dcaa0cd0edfe270ac6cceb3db80e5ba6f4725c6dc9f898e045a45cb5cd25c"
  license "MIT"

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
