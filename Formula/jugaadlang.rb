class Jugaadlang < Formula
  desc "Hindi-keyword programming language for Indian developers"
  homepage "https://jugaadlang.netlify.app"
  url "https://github.com/jugaadlang/jugaadlang/archive/refs/tags/v1.2.8.tar.gz"
  sha256 "b66fb5570b61ab44fa98ef11c727a44c676e5dbaa652a8cd4f82f67f5bea47bd"
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
    # Verify the installed CLI reports the formula version
    assert_match version.to_s, shell_output("#{bin}/jug --version")

    # Run a small JugaadLang program end-to-end
    (testpath/"hello.jug").write "bolo(\"Namaste Duniya!\")"
    assert_match "Namaste Duniya!", shell_output("#{bin}/jug run hello.jug")
  end
end
