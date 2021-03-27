terraform:
	@ if [ "${ambiente}" = "" ]; then \
		echo;\
        echo "Especifique o que você quer acessar."; \
		echo "Os nomes dos ambientes são os mesmos nomes da pasta do projeto."; \
		echo "Ex: make terraform ambiente={{nome_do_ambiente}}"; \
		echo;\
        exit 1; \
    fi
	docker container run -it -v $(PWD)/$(ambiente):/app -w /app --entrypoint "" hashicorp/terraform:light sh;