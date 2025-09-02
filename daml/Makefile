start:
	daml json-api \
		--ledger-host localhost \
		--ledger-port 5011 \
		--http-port 7575 \
		--allow-insecure-tokens    
navigator:
	daml navigator \
	--port 7500 \
	--ledger-host localhost \
	--ledger-port 5011 \
	--allow-insecure-tokens

# enterprise only
gen-alice:
	daml auth create-token \
		--ledgerid local-ledger \
		--application-id test-app \
		--act-as Alice > alice.jwt

build:
	daml build
deploy: build
	 daml deploy --host localhost --port 5011
