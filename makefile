npm:
	npm install

deploy: 
	@echo building...
	@coffee -o build src/
	@echo copy view
	@cp -rf src/view build/
	@echo copy package.json
	@cp package.json build
	@echo git push
	@cd build ; git add ./ ; git commit -a -m 'new changes' ; git push origin master

	
