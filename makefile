npm:
	npm install

run:
	#@echo kill node process
	#@killall -v node
	@echo start socket server
	@coffee new/socket.run.coffee &> socket.log &
	@echo start main server
	@coffee new/run.coffee &> server.log &

package: 
	@echo building...
	@coffee -o build new/
	#@echo copy view and static
	#@cp -rf src/view build/
	@cp -rf new/static build/static
	@echo copy package.json
	@cp package.json build

	

push113: package
	@echo make config file
	@mv build/config.113.js build/config.js
	@echo git push origin master
	@cd build ; git add ./ ; git commit -a -m 'new changes' ; git push origin master

push61: package
	@echo make config file
	@mv build/config.61.js build/config.js
	@echo git push 61 master
	@cd build ; git add ./ ; git commit -a -m 'new changes' ; git push 61 master

	
