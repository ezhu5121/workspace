
all: check 
	@echo "make <tgt>"
	@echo " update: update ecmh and depends"
	@echo " build: build ecmh"

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




