# syntax=docker/dockerfile:1
FROM phusion/baseimage:master-amd64
ENV TZ America/New_York

SHELL ["/bin/bash", "-c"]

RUN apt -y update && \
	apt -y upgrade && \
	apt install -y \
	build-essential \
	neovim \
	python3-pip \
	ipython3 \
	ruby \
	ruby-dev \
	strace \
	ltrace \
	gdb \
	gdb-multiarch \
	git \
	python3-distutils \
	file \
	wget \
	tzdata --fix-missing && \
	rm -rf /var/lib/apt/list/*

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
	dpkg-reconfigure -f noninteractive tzdata

RUN python3 -m pip install -U pip && \
	python3 -m pip install --no-cache-dir \
	ropgadget \
	ropper \
	pwntools \
	z3-solver \
	unicorn \
	keystone-engine \
	capstone \
	angr \
	pathlib2 \
	pebble

RUN gem install one_gadget seccomp-tools && rm -rf /var/lib/gems/2.*/cache/*

RUN git clone https://github.com/radareorg/radare2 && \
	radare2/sys/install.sh

RUN git clone https://github.com/pwndbg/pwndbg && \
	cd pwndbg && \
	./setup.sh && \
	cd .. && \
	mv pwndbg ~/pwndbg-src && \
	echo "source ~/pwndbg-src/gdbinit.py" > ~/.gdbinit_pwndbg

RUN git clone https://github.com/longld/peda.git ~/peda

RUN wget -q -O ~/.gdbinit-gef.py https://github.com/hugsy/gef/raw/master/gef.py

COPY .gdbinit /root/
COPY gdb-pwndbg /usr/bin/
COPY gdb-peda /usr/bin/
COPY gdb-gef /usr/bin/

RUN chmod +x /usr/bin/gdb-*

WORKDIR /ctf/work/

CMD ["/sbin/my_init"]
