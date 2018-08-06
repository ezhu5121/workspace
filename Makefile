
all: check
	@echo "** make <tgt>"
	@echo "   update: update ecmh and depends"
	@echo "   build: build ecmh"
	@echo "   install: install libecma.a

check:
	@if [ ! -f /.dockerenv ]; then \
		echo "**** Please run in docker container! ****"; \
		exit 1; \
		fi

msg: check
	@echo ">> Build ecmh ..."

subprojs := jbms-utility array_view jbms-openssl ecmh
update: check
	@for d in $(subprojs); do \
		if [ -d $$d ]; then \
			echo ">> Update $$d ...";\
			(cd $$d && git pull) || exit 1; \
		else \
				echo ">> Pull $$d ...";\
				git clone --depth=1 https://github.com/ezhu5121/$$d.git;\
		fi;\
	done

build: check
	@for d in $(subprojs); do \
		if [ ! -e $$d ]; then \
			git clone --depth=1 https://github.com/ezhu5121/$$d.git;\
		fi; \
		if [ -d $$d ]; then \
			rm -fr $$d/bld;\
			mkdir -p $$d/bld; \
			cd $$d/bld && \
			cmake .. && make && sudo make install; \
			cd ../..;\
		fi \
	done

generated_jbms = ecmh/bld
jbms_hdrs = $(shell find ecmh/src -name "*.hpp")
install: check
	cd $(generated_jbms) && \
	for f in *.a; do \
		ar -xv $$f; \
	done
	@cd $(generated_jbms) && \
		ar -rv libecmh.a `find . -name "*.o"` && \
		sudo install -v libecmh.a /usr/local/lib/ && \
		rm -f *.o libecmh.a


install-hdr: check
	cd ecmh/src && tar cf - `find jbms -name "*.hpp"` \
		|sudo tar xf - -C /usr/local/include/
	

