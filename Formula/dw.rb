class Dw < Formula
    desc "CLI Tool for dashwave"
    homepage "https://github.com/dashwave/toolkits"
    url "https://github.com/dashwave/toolkits/releases/download/v0.0.0-rev-16/dw_darwin_arm64.tar.gz"
    sha256 "b3e33c5c3369336c8f26ac3ba9c46a3bbb4d4820bfa1be3b6a1b065b0b2f7983"
    version "v0.0.0-rev-16"
  
    def install
      bin.install "dw"
    end
  end
