SHELL := /bin/bash
HOST=$(shell hostname)

export D1=/

export PYTHON3_PACKAGES=pip numpy pandas nose python-libsbml \
	cobra escher seaborn pillow bokeh dnaplotlib pysb \
	biopython openpyxl xlrd fastcluster scikit-bio \
	scikit-learn rpy2 tzlocal networkx cutadapt \
	libroadrunner distributed statsmodels biom-format \
	seqmagick pygtrie xgboost kneaddata humann2

export PYTHON2_PACKAGES=pip qiime biom-format msgpack xgboost kneaddata humann2

export DEV_PYTHON_PACKAGES=testresources twine sphinx sphinx-autobuild \
	sphinx_rtd_theme versioneer pylint autopep8

export CUDA_PYTHON3_PACKAGES=pycuda scikit-cuda \
	torch torchvision tensorflow-gpu theano cntk-gpu keras

export JUPYTER_PACKAGES=jupyter jupyterlab ipykernel nbopen rise

export PERL_PACKAGES=App::cpanminus CPAN

export PERL_CPANM=App::cpanoutdated Test::Pod::Coverage JSON Math::CDF HTML::Template \
	XML::Compile::SOAP11 XML::Compile::WSDL11 XML::Compile::Transport::SOAPHTTP \
	Bio::Perl Statistics::R Bio::DB::Taxonomy XML::LibXML LWP::Simple Text::CSV \
	Bio::Perl JSON File::Slurp XML::DOM::XPath GD

export R_PACKAGES=tidyverse knitr rmarkdown gridExtra plotly Cairo ggpubr ape \
	biom optparse RColorBrewer randomForest vegan apcluster chron compare compute.es \
	d3heatmap dendextend DEoptimR diptest fastmatch flexmix fpc kernlab mclust mds \
	modeltools mvtnorm NLP phangorn pheatmap plotrix PMCMR png prabclus \
	qdapDictionaries qdapRegex quadprog rafalib reports robustbase rvcheck segmented \
	seqinr slam tidytree trimcluster UpSetR wordcloud freetypeharfbuzz EQUIVNONINF \
	xgboost ROCR

export BIOCONDUCTOR=dada2 edgeR phyloseq DESeq DESeq2 microbiome \
	BiocVersion ggtree graph hypergraph treeio metagenomeSeq SIAMCAT \
	cluster clusterSim

.ONESHELL:
test:
	echo $(HOME)
	echo $$(which pip3)
	echo $(HOST)

.ONESHELL:
apt-install:
	sudo apt update
	sudo apt -y upgrade
	sudo apt -y dist-upgrade
	sudo apt -y remove xul-ext-ubufox gedit

	APTS="ant apt-file aptitude autoconf baobab biom-format-tools bison bowtie bowtie2 \
		cargo cd-hit chrome-gnome-shell cmake cufflinks curl dejagnu ea-utils fasttree \
		flex ghostscript gimp gir1.2-clutter-1.0 gir1.2-gtop-2.0 \
		gir1.2-networkmanager-1.0 gnome-themes-standard gnome-tweak-tool gparted htop \
		infernal inkscape kate kmc kompare lftp libatlas-base-dev libboost-all-dev \
		libcanberra-gtk-module libcanberra-gtk3-module libcereal-dev \
		libcurl4-openssl-dev libdivsufsort-dev libgd-dev libgdal-dev libgirepository1.0-dev \
		libgsl-dev libhpdf-dev libjemalloc-dev libkrb5-dev libmagick++-dev \
		libopenmpi-dev libreoffice libstaden-read-dev libtbb-dev libtool libudunits2-dev \
		libxm4 lm-sensors mafft maven nautilus-dropbox ncbi-blast+ net-tools nfs-common \
		nfs-kernel-server nodejs ocamlbuild opam openjdk-11-jdk-headless openjdk-8-jdk \
		openjdk-8-jre openssh-server pandoc pdfshuffler python-pip python-tk r-base rar \
		rename ruby speedtest-cli sra-toolkit sshfs synaptic tophat \
		ttf-mscorefonts-installer virtualbox vlc emboss bioperl ncbi-blast+ gzip unzip \
		libjson-perl libtext-csv-perl libfile-slurp-perl liblwp-protocol-https-perl \
		libwww-perl bcftools bamtools samtools bedtools"

	PYTHON3_DEPS="python3-pip python3-tk python3-h5py build-essential \
	checkinstall libssl-dev zlib1g-dev libncurses5-dev \
	libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
	libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev uuid-dev"

	R_DEPS="libcairo2-dev libxt-dev libtiff5-dev libssh2-1-dev libxml2 libxml2-dev"

	OPAM="yojson"

	for apt in $$APTS; do sudo apt -y install $$apt; done
	for apt in $$PYTHON3_DEPS; do sudo apt -y install $$apt; done
	for apt in $$R_DEPS; do sudo apt -y install $$apt; done

	sudo apt -y autoremove
	sudo apt -y autoclean
	sudo apt -y clean

latex-install:
	sudo apt-get -y install texstudio texlive-full

system-perl-packages-install:
	sudo cpan $$PERL_PACKAGES
	sudo cpanm $$PERL_CPANM -n

system-pip3-install:
	for package in $$PYTHON3_PACKAGES; do \
		sudo -H pip3 install $$package --upgrade; done

	for package in $$DEV_PACKAGES; do \
		sudo -H pip3 install $$package --upgrade; done

	for package in $$CUDA_PYTHON3_PACKAGES; do \
		sudo -H pip3 install $$package --upgrade; done

local-pip3-install:
	for package in $$PYTHON3_PACKAGES; do \
		$$D1/opt/python-3.6.5/bin/pip3 install $$package --upgrade;
		$$D1/opt/python-3.7.0/bin/pip3 install $$package --upgrade; done

	for package in $$DEV_PACKAGES; do \
		$$D1/opt/python-3.6.5/bin/pip3 install $$package --upgrade;
		$$D1/opt/python-3.7.0/bin/pip3 install $$package --upgrade; done

system-jupyter-install:
	for package in $$JUPYTER_PACKAGES; do \
		sudo -H pip3 install $$package --upgrade; done

	# install python3.6.5 kernel
	python3 -m ipykernel install --user
	python3 -m nbopen.install_xdg

	# install and enable rise
	sudo jupyter-nbextension install rise --py --sys-prefix
	sudo jupyter-nbextension enable rise --py --sys-prefix

cuda-install:
	cd $$D1/opt/ubuntu-software

	sudo apt -y install linux-headers-$(uname -r)
	sudo dpkg -i cuda-repo-ubuntu1804-10-0-local-10.0.130-410.48_1.0-1_amd64.deb
	sudo apt-key add /var/cuda-repo-10-0-local-10.0.130-410.48/7fa2af80.pub
	sudo apt update
	sudo apt -y install cuda

	CUDA_APTS="cuda-toolkit-10-0 cuda-tools-10-0 cuda-runtime-10-0 \
		cuda-compiler-10-0 cuda-libraries-10-0 cuda-libraries-dev-10-0 \
		cuda-drivers nvidia-cuda-toolkit"

	for apt in $$CUDA_APTS; do sudo apt -y install $$apt; done
	sudo dpkg -i libcudnn7_7.3.1.20-1+cuda10.0_amd64.deb \
		libcudnn7-dev_7.3.1.20-1+cuda10.0_amd64.deb libcudnn7-doc_7.3.1.20-1+cuda10.0_amd64.deb

local-cuda-pip3-install:
	for package in $$CUDA_PYTHON3_PACKAGES; do \
		$$D1/opt/python-3.6.5/bin/pip3 install $$package --upgrade;
		$$D1/opt/python-3.7.0/bin/pip3 install $$package --upgrade; done

local-jupyter-install:
	for package in $$JUPYTER_PACKAGES; do \
		$$D1/opt/python-3.6.5/bin/pip3 install $$package --upgrade; done

	# install python3.6.5 kernel
	$$D1/opt/python-3.6.5/bin/python3 -m ipykernel install --user
	$$D1/opt/python-3.6.5/bin/python3 -m nbopen.install_xdg

	# install and enable rise
	$$D1/opt/python-3.6.5/bin/jupyter-nbextension install rise --py --sys-prefix
	$$D1/opt/python-3.6.5/bin/jupyter-nbextension enable rise --py --sys-prefix

.ONESHELL:
python2.7.16-compile:
	mkdir -p $$D1/opt/ubuntu-software

	wget https://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz \
	-O $$D1/opt/ubuntu-software/Python-2.7.16.tgz
	if [ -d $$D1/opt/Python-2.7.16 ]; then rm -rf $$D1/opt/Python-2.7.16; fi
	tar xvzf $$D1/opt/ubuntu-software/Python-2.7.16.tgz -C $$D1/opt
	cd $$D1/opt/Python-2.7.16
	if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/python-2.7.16 ]; then rm -rf $$D1/opt/python-2.7.16; fi
	./configure --prefix=$$D1/opt/python-2.7.16 --enable-optimizations
	make
	make install

.ONESHELL:
python3.6.5-compile:
	mkdir -p $$D1/opt/ubuntu-software

	wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz \
	-O $$D1/opt/ubuntu-software/Python-3.6.5.tgz
	if [ -d $$D1/opt/Python-3.6.5 ]; then rm -rf $$D1/opt/Python-3.6.5; fi
	tar xvzf $$D1/opt/ubuntu-software/Python-3.6.5.tgz -C $$D1/opt
	cd $$D1/opt/Python-3.6.5
	if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/python-3.6.5 ]; then rm -rf $$D1/opt/python-3.6.5; fi
	./configure --prefix=$$D1/opt/python-3.6.5 --enable-optimizations
	make
	make install

.ONESHELL:
python3.7.0-compile:
	mkdir -p $$D1/opt/ubuntu-software

	wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz \
	-O $$D1/opt/ubuntu-software/Python-3.7.0.tgz
	if [ -d $$D1/opt/Python-3.7.0 ]; then rm -rf $$D1/opt/Python-3.7.0; fi
	tar xvzf $$D1/opt/ubuntu-software/Python-3.7.0.tgz -C $$D1/opt
	cd $$D1/opt/Python-3.7.0
	if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/python-3.7.0 ]; then rm -rf $$D1/opt/python-3.7.0; fi
	./configure --prefix=$$D1/opt/python-3.7.0 --enable-optimizations
	make
	make install

.ONESHELL:
r-3.5.0-compile:
	mkdir -p $$D1/opt/ubuntu-software

	wget https://cloud.r-project.org/bin/linux/ubuntu/bionic-cran35/r-base_3.5.0.orig.tar.gz \
	-O $$D1/opt/ubuntu-software/R-3.5.0.tgz
	if [ -d $$D1/opt/R-3.5.0 ]; then rm -rf $$D1/opt/R-3.5.0; fi
	tar xvzf $$D1/opt/ubuntu-software/R-3.5.0.tgz -C $$D1/opt
	cd $$D1/opt/R-3.5.0
	if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/r-3.5.0 ]; then rm -rf $$D1/opt/r-3.5.0; fi
	./configure --prefix=$$D1/opt/r-3.5.0 --enable-R-shlib --with-blas --with-lapack
	make
	make install

.ONESHELL:
r-3.5.2-compile:
	mkdir -p $$D1/opt/ubuntu-software

	wget https://cloud.r-project.org/bin/linux/ubuntu/bionic-cran35/r-base_3.5.2.orig.tar.gz \
	-O $$D1/opt/ubuntu-software/R-3.5.2.tgz
	if [ -d $$D1/opt/R-3.5.2 ]; then rm -rf $$D1/opt/R-3.5.2; fi
	tar xvzf $$D1/opt/ubuntu-software/R-3.5.2.tgz -C $$D1/opt
	cd $$D1/opt/R-3.5.2
	if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/r-3.5.2 ]; then rm -rf $$D1/opt/r-3.5.2; fi
	./configure --prefix=$$D1/opt/r-3.5.2 --enable-R-shlib --with-blas --with-lapack
	make
	make install

local-r-libraries-install:
	# install R packages
	for package in $$R_PACKAGES; do $$D1/bin/R -e \
		"install.packages('$$package', dependencies = TRUE, repos = 'https://cloud.r-project.org/')"; done

	# install Bioconductor packages
	$$D1/bin/R -e \
		"if (!requireNamespace(\"BiocManager\", quietly = TRUE)) \
		install.packages(\"BiocManager\", dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	for package in $$BIOCONDUCTOR; do $$D1/bin/R -e "BiocManager::install(\"$$package\", version = \"3.8\")"; done

.ONESHELL:
r-kernels-jupyter:
	$$D1/bin/R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
	library(devtools); \
	devtools::install('$$D1/opt/github-repositories/IRkernel.IRkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'cran')"

.ONESHELL:
slurm-install:
	sudo apt-get -y remove --purge munge slurm-wlm slurmdbd
	sudo apt-get -y autoremove
	sudo apt-get -y install munge slurm-wlm slurmdbd

.ONESHELL:
slurm-conf:
	sudo systemctl stop munge
	sudo systemctl stop slurmd

	if [[ "$(HOST)" == "nbl1" ]] ; then
		sudo systemctl stop slurmctld
		sudo systemctl stop slurmdbd
	fi

	sudo rm -rf /var/lib/slurm-llnl /var/run/slurm-llnl /var/log/slurm-llnl

	sudo mkdir -p /var/spool/slurmd
	sudo mkdir -p /var/lib/slurm-llnl
	sudo mkdir -p /var/lib/slurm-llnl/slurmd
	sudo mkdir -p /var/lib/slurm-llnl/slurmctld
	sudo mkdir -p /var/run/slurm-llnl
	sudo mkdir -p /var/log/slurm-llnl

	sudo chmod -R 755 /var/spool/slurmd
	sudo chmod -R 755 /var/lib/slurm-llnl/
	sudo chmod -R 755 /var/run/slurm-llnl/
	sudo chmod -R 755 /var/log/slurm-llnl/

	sudo chown -R slurm:slurm /var/spool/slurmd
	sudo chown -R slurm:slurm /var/lib/slurm-llnl/
	sudo chown -R slurm:slurm /var/run/slurm-llnl/
	sudo chown -R slurm:slurm /var/log/slurm-llnl/

	sudo cp slurm.conf gres.conf /etc/slurm-llnl/

	if [[ "$(HOST)" == "nbl1" ]] ; then
		dd if=/dev/urandom bs=1 count=1024 > ./munge.key
	fi

	sudo rsync -avu -P munge.key /etc/munge/munge.key
	sudo chown munge:munge /etc/munge/munge.key
	sudo chmod 400 /etc/munge/munge.key
	sudo chmod 711 /var/lib/munge/
	sudo chmod 755 /var/run/munge/

	sudo systemctl restart munge
	sudo service munge status

	sudo systemctl restart slurmd
	sudo service slurmd status

	if [[ "$(HOST)" == "nbl1" ]] ; then
		sudo systemctl restart slurmctld
		sudo service slurmctld status
	else
		sudo systemctl stop slurmctld
		sudo service slurmctld status
	fi

.ONESHELL:
others-install:
	cd $$D1/opt/ubuntu-software/

	sh Anaconda3-5.3.0-Linux-x86_64.sh
	sh cplex_studio128.linux-x86-64.bin
	sh Cytoscape_3_7_0_unix.sh

	PTOOLS="pathway-tools-21.5-linux-64-tier1-install"
	chmod u+x $(PTOOLS); ./$(PTOOLS); chmod u-x $(PTOOLS)

	tar xvzf COPASI-4.24.197-Linux-64bit.tar.gz -C $$D1/opt
	tar xvzf gurobi8.0.1_linux64.tar.gz -C $$D1/opt
