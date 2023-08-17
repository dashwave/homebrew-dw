class Dw < Formula
    desc "CLI Tool for dashwave"
    homepage "https://github.com/dashwave/toolkits"
    
    require "json"
    require "net/http"
    require "open-uri"
    require "digest/sha2"
    
    class << self
      def latest_release_info
        uri = URI.parse("https://api.github.com/repos/dashwave/toolkits/releases/latest")
        response = Net::HTTP.get_response(uri)
        
        unless response.is_a?(Net::HTTPSuccess)
          raise "Could not fetch latest release info"
        end
        
        JSON.parse(response.body)
      end
      
      def latest_release_url
        release_info = latest_release_info()
        assets = release_info['assets']
        
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
    
        asset = assets.find do |a|
          a['browser_download_url'].include?("#{os}_#{arch}")
        end
        
        raise "Could not find appropriate asset for release" if asset.nil?
        
        asset['browser_download_url']
      end
      
      def latest_release_sha
        url = latest_release_url()
        sha256 = Digest::SHA256.file(URI.parse(url).open).hexdigest
        sha256
      end
      
      def version
        latest_release_info['tag_name']
      end
    end
    
    url Dw.latest_release_url
    sha256 Dw.latest_release_sha
    version Dw.version
    
    depends_on "rsync"
    depends_on "esolitos/ipa/sshpass"
    depends_on "wget"
  
    def install
      bin.install "dw"
    end
  end
  