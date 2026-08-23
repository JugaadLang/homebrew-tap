class Jugaadlang < Formula
  desc "Hindi-keyword programming language for Indian developers"
  homepage "https://jugaadlang.netlify.app"
  url "https://github.com/jugaadlang/jugaadlang/archive/refs/tags/v1.1.6.tar.gz"
  sha256 "8358b3f429a3a407432b82f2742146813a0b7ae5d2f9b123841ae991f1ec5a92"
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