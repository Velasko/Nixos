{ ... }: {
  services.resolved.enable = true;
  services.openvpn.servers = {
    italy = {
      updateResolvConf = true;
      autoStart = false;
      authUserPass = {
        username = "";
        password = "";
      };
      config = builtins.split [ "<crl-verify>*</crl-verify>" ] ''
                		client
                		dev tun
                		proto udp
                		remote italy.privacy.network 1198
                		resolv-retry infinite
                		nobind
                		persist-key
                		persist-tun
                		cipher aes-128-cbc
                		auth sha1
                		tls-client
                		remote-cert-tls server

                		auth-user-pass
                		compress
                		verb 1
                		reneg-sec 0

                		<crl-verify>
        				-----BEGIN X509 CRL-----
        				-----END X509 CRL-----
        				</crl-verify>

        				ca ${./ca.rsa.2048.crt}

                		disable-occ
      '';
    };
  };
}
