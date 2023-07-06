class Dw < Formula
    desc "CLI Tool for dashwave"
    homepage "https://github.com/dashwave/toolkits"

    if OS.mac?
        if Hardware::CPU.arm?
            url "https://github.com/dashwave/toolkits/releases/download/v0.0.0-rev-16/dw_darwin_arm64.tar.gz"
            sha256 "b3e33c5c3369336c8f26ac3ba9c46a3bbb4d4820bfa1be3b6a1b065b0b2f7983"
        elsif Hardware::CPU.intel?
            url "https://github.com/dashwave/toolkits/releases/download/v0.0.0-rev-16/dw_darwin_amd64.tar.gz"
            sha256 "9197b93e8ff3ba7fdcee4a9ec9e0f6d3a526fbac30da25c6d59323bae2c9e78d"
        else
            onoe "Unsupported macos architecture"
            abort
        end
    elsif OS.Linux?
        if Hardware::CPU.arm?
            url "https://github.com/dashwave/toolkits/releases/download/v0.0.0-rev-16/dw_linux_arm64.tar.gz"
            sha256 "3a699cb20de43bb57d56bfff0ed6efde638d73d3d8b23a6ba4d89b9c268ebe91"
        elsif Hardware::CPU.intel?
            url "https://github.com/dashwave/toolkits/releases/download/v0.0.0-rev-16/dw_linux_amd64.tar.gz"
            sha256 "28d75d3143e401722d19cf785452b8e324dc635df6b051c930769d614a2c2b50"
        else
            onoe "Unsupported linux architecture"
            abort
        end
    else
        onoe "Unsupported OS"
        abort
    end
  
    version "v0.0.0-rev-16"
    depends on "rsync"
    depends on "esolitos/ipa/sshpass"
    depends on "wget"

    def install
      bin.install "dw"
    end
  end
