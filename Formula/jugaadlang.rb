class Jugaadlang < Formula
  desc "Hindi-keyword programming language for Indian developers"
  homepage "https://jugaadlang.netlify.app"
  url "https://github.com/jugaadlang/jugaadlang/archive/refs/tags/v1.1.4.tar.gz"
  sha256 "0eeb6c482c46cd684b60e100880d8c5b5229bb8d8c1a901e3c32d0c94446d7e0"
  license "MIT"

  depends_on "python@3.12"

  def install
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
