{ pkgs, ... }:
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ../../hardware/optiplex-9020.nix
    ../../octoprint
    ../../webcam
    ../../git-repo
  ];

  networking.hostName = "fb";

  services.haproxy = {
    enable = true;
    config = ''
global
        maxconn 4096
        tune.ssl.default-dh-param 2048
defaults
        log     global
        mode    http
        compression algo gzip
        option  httplog
        option  dontlognull
        retries 3
        option redispatch
        option http-server-close
        option forwardfor
        maxconn 2000
        timeout connect 5s
        timeout client  15m
        timeout server  15m

frontend public
        bind :::80 v4v6
        bind :::443 v4v6 ssl crt ${./snakeoil.pem}
        option forwardfor except 127.0.0.1
        use_backend webcam if { path_beg /webcam/ }
        use_backend webcam_hls if { path_beg /hls/ }
        use_backend webcam_hls if { path_beg /jpeg/ }
        default_backend octoprint

backend octoprint
        acl needs_scheme req.hdr_cnt(X-Scheme) eq 0

        http-request replace-path ^([^\ :]*)\ /(.*) \1\ /\2
        http-request add-header X-Scheme https if needs_scheme { ssl_fc }
        http-request add-header X-Scheme http if needs_scheme !{ ssl_fc }
        option forwardfor
        server octoprint1 127.0.0.1:5000

backend webcam
        http-request replace-path /webcam/(.*) /\1
        server webcam1  127.0.0.1:5050

backend webcam_hls
        server webcam_hls_1 127.0.0.1:28126
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
