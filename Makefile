
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
#generated_hdrs = $(shell cd $(generated_jbms)/src; find jbms -name "*.hpp")
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
		|sudo tar xf - -C /usr/local/include/;
	cd ecmh/bld/src && tar cf - `find jbms -name "*.hpp"` | \
		sudo tar xf - -C /usr/local/include/;

demo.o: demo.cpp
	clang++ -std=c++1y -march=native $(CPPFLAGS) $(OPENSSL_INCS)  -c -o $@ $<

INCS := /usr/local/include \
		/usr/local/include/jbms-openssl/src\
		/usr/local/include/jbms-utility/src\
		/usr/local/include/jbms-array_view/src\
		/usr/local/include/jbms
CPPFLAGS += $(addprefix -I,$(INCS))
OPENSSL_INCS := $(shell PKG_CONFIG_PATH=/usr/local/ssl/lib/pkgconfig/; pkg-config --cflags openssl)
OPENSSL_LIBS := $(shell PKG_CONFIG_PATH=/usr/local/ssl/lib/pkgconfig/; pkg-config --libs openssl)
demo: demo.o
	clang++ $(OPENSSL_LIBS) -L/usr/local/lib -static demo.o -lecmh -o $@


