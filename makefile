npm:
	npm install

deploy: 
	@echo building...
	@coffee -o build -c src/
	@echo copy package.json
	@cp package.json build
	@echo git push
	@cd build | git add ./ | git commit -m 'new changes' | git push

	
