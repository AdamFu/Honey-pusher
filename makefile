npm:
	npm install

package: 
	@echo building...
	@coffee -o build src/
	@echo copy view
	@cp -rf src/view build/
	@echo copy package.json
	@cp package.json build

push113: package
	@echo git push origin master
	@cd build ; git add ./ ; git commit -a -m 'new changes' ; git push origin master

push61: package
	@echo git push 61 master
	@cd build ; git add ./ ; git commit -a -m 'new changes' ; git push 61 master

	
