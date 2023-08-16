class Dw < Formula
    desc "CLI Tool for dashwave"
    homepage "https://github.com/dashwave/toolkits"
    
    def latest_release_url
      uri = URI.parse("https://api.github.com/repos/dashwave/toolkits/releases/latest")
      response = Net::HTTP.get_response(uri)
      json = JSON.parse(response.body)
      assets = json['assets']
      os, arch = if OS.mac?
                   if Hardware::CPU.arm?
                     ['darwin', 'arm64']
                   else
                     ['darwin', 'amd64']
                   end
                 elsif OS.linux?
                   if Hardware::CPU.arm?
                     ['linux', 'arm64']
                   else
                     ['linux', 'amd64']
                   end
                 else
                   raise "Unsupported OS"
                 end
      assets.find do |a|
        a['browser_download_url'].include?("#{os}_#{arch}")
      end['browser_download_url']
    end
    
    def latest_release_sha
      url = latest_release_url()
      sha256 = Digest::SHA256.file(URI.parse(url).open).hexdigest
      sha256
    end
  
    url latest_release_url
    sha256 latest_release_sha
    version "latest"
    
    depends_on "rsync"
    depends_on "esolitos/ipa/sshpass"
    depends_on "wget"
  
    def install
      bin.install "dw"
    end
  end
  