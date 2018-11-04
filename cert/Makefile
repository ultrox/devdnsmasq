%:
	@:
args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`
DOMAIN=$(call args,dora.dev)

genRootCAKeyPWD:
	openssl genrsa -des3 -out ./ca/rootCA.key 4096
1genRootCAKey:
	openssl genrsa -out ./ca/rootCA.key 4096
2genRootCACert:
	openssl req -x509 -new -nodes -key ./ca/rootCA.key -sha256 -days 1024 -out ./ca/rootCA.crt
addRootCA:
	sudo security add-trusted-cert -d -k /Library/Keychains/System.keychain ./ca/rootCA.crt
rmRootCA:
	sudo security delete-certificate -c rootCA.crt /Library/Keychains/System.keychain

# for creating sites
# creating Ca-Singed Certificates for your dev sites
setup:
	./utils/setup ${DOMAIN}
rmdomains:
	rm -rf ./domains/*
gen: 
	openssl genrsa -out ./domains/${DOMAIN}.key 4096 && \
	openssl req -new -sha256 -key ./domains/${DOMAIN}.key -subj "/C=US/ST=CA/O=JovoOrg, Inc./CN=${DOMAIN}" -out ./domains/${DOMAIN}.csr && \
	./utils/genConfig.sh ${DOMAIN} && \
		openssl x509 -req -in ./domains/${DOMAIN}.csr \
	       -CA ./ca/rootCA.crt -CAkey ./ca/rootCA.key \
	       -CAcreateserial -out ./domains/${DOMAIN}.crt -days 1024 \
	       -sha256 -extfile ./domains/${DOMAIN}.ext
lazy: 
	openssl genrsa -out ./domains/${DOMAIN}.key 4096 && \
	openssl req -new -sha256 -key ./domains/${DOMAIN}.key -subj "/C=US/ST=CA/O=JovoOrg, Inc./CN=${DOMAIN}" -out ./domains/${DOMAIN}.csr && \
	./utils/genConfig.sh ${DOMAIN} && \
		openssl x509 -req -in ./domains/${DOMAIN}.csr \
	       -CA ./ca/rootCA.crt -CAkey ./ca/rootCA.key \
	       -CAcreateserial -out ./domains/${DOMAIN}.crt -days 1024 \
	       -sha256 -extfile ./domains/${DOMAIN}.ext && ./utils/setup ${DOMAIN}

