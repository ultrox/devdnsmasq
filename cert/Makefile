%:
	@:
args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`
DOMAIN=$(call args,dora.dev)

define lazy_gen
	openssl genrsa -out ./domains/$(1).key 4096 && \
	openssl req -new -sha256 -key ./domains/${1}.key -subj "/C=US/ST=CA/O=JovoOrg, Inc./CN=${1}" -out ./domains/${1}.csr && \
	./utils/genConfig.sh ${1} && \
		openssl x509 -req -in ./domains/${1}.csr \
	       -CA ./ca/rootCA.crt -CAkey ./ca/rootCA.key \
	       -CAcreateserial -out ./domains/${1}.crt -days 1024 \
	       -sha256 -extfile ./domains/${1}.ext
endef

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
	$(call lazy_gen,${DOMAIN})
proxy_app: 
	$(call lazy_gen,${DOMAIN}) && ./utils/setup ${DOMAIN} proxy_pass_nginx
lazy:
	$(call lazy_gen,${DOMAIN}) && ./utils/setup ${DOMAIN} example
