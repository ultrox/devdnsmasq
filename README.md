## Requirenments:

- MacOs(but you can adapt it to linux)

## What is this
My solution to run my own services/apps/projects on `.dev` or any domain I want, and moving from `localhost:3000`.

I run nginx on my host machine on port 80, based on the project I generate `sites-enabled` .config file.

Running dns server in docker with front facing nginx running on host:80

To use dnsmasq you need to setup your DNS server to localhost 127.0.0.1 as one
of the servers.

- If you want to use `.dev` TLD you need to install self sign certificate, mostly
  over the fact Chrome redirect automatically to https
  I created helper scripts for in `cert` folder. HOWEVER you don't need to use
  it if you use special `.test`.
  

## Create self sign `.dev` or any TLD
Again, this is not necessary related to dnsmask

1. go to `cert` and run 
    - `make gen 1genRootCAKey`
  - more secure & sane  version is to use pswd with this, but then full
    automation is harder 
    - `make gen genRootCAKeyPWD`

2. Now you need to self sign the root Certificate 
     - `make 2genRootCACert`

      and fill all the information to identify yourself as CA(certify authority), mostly not important.

3. Add your newly created certificate to key-chain in MAC
    - `make addRootCA`
4. Create domain `make gen domain.com`
    - it will create certificate and paste it to `domains` 

Keep in mind, after you create steps 1,2 & 3 for the next domain, you are doing
any step 4.

## Explanation:

- `myCertifyAuthority.key` => this is private key for your Authority
- `myCertifyAuthority.cert` => this is the root certificate generated based on your
key, you create 'organization' with it

After having them both, you are 'tiny CA' and can sign certificates :)

# SOURCES:
- Majority is from [create root CA](https://gist.github.com/ultrox/ed1fa9081a1a25ebe6ddea5715309bbd)
- [delicious brain](https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/)
