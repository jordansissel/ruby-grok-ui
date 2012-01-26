run:
	node /home/jls/node_modules/hem/bin/hem server

build:
	node /home/jls/node_modules/hem/bin/hem build

heroku-deploy: | build update-cache-manifest
	-git add public/application.css public/application.js
	-git commit public/application.css public/application.js -m "regenerated"
	git push heroku master

heroku-test-deploy: | build update-cache-manifest
	-git add public/application.css public/application.js
	-git commit public/application.css public/application.js -m "regenerated"
	git push heroku-2 master

deploy: | heroku-deploy heroku-test-deploy

update-cache-manifest: VERSION=$(shell date +%s)
update-cache-manifest:
	sed -i -e 's,^# v.*,# v$(VERSION),' public/cache.manifest
	git commit public/cache.manifest -m "regenerate"

gh-pages: SOURCES=application.css application.js index.html favicon.ico
gh-pages: | build update-cache-manifest
	tar -zcf /tmp/gh-pages.tar.gz -C public $(SOURCES)
	git checkout gh-pages
	tar -zxf /tmp/gh-pages.tar.gz
	git add $(SOURCES)
	git commit $(SOURCES) public/cache.manifest -m "regenerated"
	git checkout master
