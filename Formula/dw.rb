class Dw < Formula
    desc "CLI Tool for dashwave"
    homepage "https://github.com/dashwave/toolkits"

    def getLastestVersion
        url = URI("https://api.github.com/repos/dashwave/toolkits/releases/latest")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)

        response = http.request(request)
        parsed_json = JSON.parse(response.body)

        parsed_json['tag_name'].gsub(/\s+/, "")
    end

    version getLastestVersion

    if OS.mac?
        if Hardware::CPU.arm?
            url "https://github.com/dashwave/toolkits/releases/download/" + version + "/dw_darwin_arm64.tar.gz"
            sha256 "a34d32449d8165d8f69f114c890a00bc57cd315826a59eb92c7f37a737a0867b"
        elsif Hardware::CPU.intel?
            url "https://github.com/dashwave/toolkits/releases/download/" + version + "/dw_darwin_amd64.tar.gz"
            sha256 "681bf8de0d0419e63beffff07c2dd424940157b42f84367a383640f08e07debd"
        else
            onoe "Unsupported macos architecture"
            abort
        end
    elsif OS.linux?
        if Hardware::CPU.arm?
            url "https://github.com/dashwave/toolkits/releases/download/v0.1.0/dw_linux_arm64.tar.gz"
            sha256 "ddcbbe802ef4a38fc4c37dd5114ab2be93f2d4b9b715d03c358515dd6a7f48f6"
        elsif Hardware::CPU.intel?
            url "https://github.com/dashwave/toolkits/releases/download/v0.1.0/dw_linux_amd64.tar.gz"
            sha256 "eca3b3749412594b4a587665e0479c2ef617d6a061d6ea35c18e14247b739d13"
        else
            onoe "Unsupported linux architecture"
            abort
        end
    else
        onoe "Unsupported OS"
        abort
    end

    depends_on "rsync"
    depends_on "esolitos/ipa/sshpass"
    depends_on "wget"

    def install
      bin.install "dw"
    end
  end
