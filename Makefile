SHELL := /bin/bash
HOST=$(shell hostname)

export D1=/shared/D1
export r_version=3.6.2
export python3_v=3.6.5
export python2_v=2.7.17

# use virtual environment for anvio
export PYTHON3_PACKAGES=pip numpy pandas nose python-libsbml \
	cobra escher seaborn pillow bokeh dnaplotlib pysb \
	biopython bioservices openpyxl xlrd fastcluster scikit-bio \
	scikit-learn rpy2 tzlocal networkx cutadapt \
	libroadrunner distributed statsmodels biom-format \
	seqmagick pygtrie xgboost kneaddata humann2 pysundials keyrings.alt dask_jobqueue

export PYTHON2_PACKAGES=pip qiime biom-format msgpack xgboost kneaddata humann2

export DEV_PYTHON_PACKAGES=testresources twine sphinx sphinx-autobuild \
	sphinx_rtd_theme versioneer pylint autopep8 pyscaffold

export CUDA_PYTHON3_PACKAGES=pycuda scikit-cuda \
	torch torchvision tensorflow-gpu theano cntk-gpu keras

export JUPYTER_PACKAGES=jupyter jupyterlab ipykernel nbopen rise

export PERL_PACKAGES=App::cpanminus CPAN

export PERL_CPANM=App::cpanoutdated Test::Pod::Coverage JSON Math::CDF HTML::Template \
	XML::Compile::SOAP11 XML::Compile::WSDL11 XML::Compile::Transport::SOAPHTTP \
	Bio::Perl Statistics::R Bio::DB::Taxonomy XML::LibXML LWP::Simple Text::CSV \
	Bio::Perl JSON File::Slurp XML::DOM::XPath GD App::Cmd::Setup

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

	APTS="ant apt-file aptitude artemis autoconf bamtools baobab barrnap bcftools bedtools \
		biom-format-tools bioperl bison bowtie bowtie2 bwa capnproto cargo cd-hit \
		chrome-gnome-shell cmake cufflinks curl dejagnu diamond-aligner ea-utils emboss \
		fastqc fasttree fastx-toolkit flex ghostscript gimp gir1.2-clutter-1.0 \
		gir1.2-gtop-2.0 gir1.2-networkmanager-1.0 gnome-themes-standard gnome-tweak-tool \
		gparted gzip hisat2 htop idba infernal inkscape kate kmc kompare lftp \
		libatlas-base-dev libboost-all-dev libcanberra-gtk3-module \
		libcanberra-gtk-module libcereal-dev libcurl4-openssl-dev libdivsufsort-dev \
		libfile-slurp-perl libgdal-dev libgd-dev libgirepository1.0-dev libgsl-dev \
		libhpdf-dev libhts-dev libjemalloc-dev libjson-perl libkrb5-dev \
		liblwp-protocol-https-perl libmagick++-dev libopenmpi-dev libreoffice \
		libstaden-read-dev libsundials-dev libtbb-dev libtext-csv-perl libtool \
		libudunits2-dev libwww-perl libxm4 lm-sensors mafft mash maven nautilus-dropbox \
		ncbi-blast+ ncbi-blast+ net-tools nfs-common nfs-kernel-server nodejs ocamlbuild \
		opam openjdk-11-jdk-headless openjdk-8-jdk openjdk-8-jre openssh-server pandoc \
		pdfshuffler prodigal python-pip python-tk python3-pip python3-tk rar r-base \
		rename ruby salmon samtools sbmltoolbox soapdenovo2 spades speedtest-cli \
		sra-toolkit sshfs synaptic tophat trimmomatic ttf-mscorefonts-installer unzip \
		velvet virtualbox vlc vsearch python-numpy cython libblas-dev liblapacke \
		gfortran libopenblas-dev liblapack-dev zlibc zlib1g-dev zlib1g sqlite sqlite3 \
		libsparsehash-dev libhdf5-serial-dev libsundials-dev libglfw3-dev mailutils \
		libjemalloc1 libjemalloc-dev gcc-4.8 g++-4.8 libsparsehash-dev roary \
		libdist-zilla-perl systemtap auditd rubber ubuntu-server"

	PYTHON3_DEPS="python3-pip python3-tk python3-h5py build-essential \
		checkinstall libssl-dev zlib1g-dev libncurses5-dev \
		libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
		libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev uuid-dev"

	R_DEPS="libcairo2-dev libxt-dev libtiff5-dev libssh2-1-dev libxml2 libxml2-dev"

	for apt in $$APTS; do sudo apt -y install $$apt; done
	for apt in $$PYTHON3_DEPS; do sudo apt -y install $$apt; done
	for apt in $$R_DEPS; do sudo apt -y install $$apt; done

	sudo apt -y autoremove
	sudo apt -y autoclean
	sudo apt -y clean

latex-install:
	sudo apt-get -y install texstudio texlive-full

cuda-download:
	cd $$D1/opt/ubuntu-software
	wget --continue https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
	wget --continue http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb

cuda-install:
	cd $$D1/opt/ubuntu-software

	sudo apt -y install linux-headers-$(uname -r)
	sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600

	sudo dpkg -i cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
	sudo apt-key add /var/cuda-repo-10-2-local-10.2.89-440.33.01/7fa2af80.pub
	sudo apt-get update
	sudo apt-get -y install cuda

	CUDA_APTS="nvidia-cuda-toolkit"

	for apt in $$CUDA_APTS; do sudo apt -y install $$apt; done
# 	sudo dpkg -i libcudnn7_7.3.1.20-1+cuda10.0_amd64.deb \
# 		libcudnn7-dev_7.3.1.20-1+cuda10.0_amd64.deb libcudnn7-doc_7.3.1.20-1+cuda10.0_amd64.deb

local-rpackages-install:
	# install R packages
	for package in $$R_PACKAGES; do $$D1/opt/R-$$r_version/bin/R -e \
		"install.packages('$$package', dependencies = TRUE, repos = 'https://cloud.r-project.org/')"; done

	# install Bioconductor packages
	$$D1/opt/R-$$r_version/R -e \
		"if (!requireNamespace(\"BiocManager\", quietly = TRUE)) \
		install.packages(\"BiocManager\", dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	for package in $$BIOCONDUCTOR; do $$D1/opt/R-$$r_version/bin/R -e "BiocManager::install(\"$$package\", version = \"3.8\")"; done

.ONESHELL:
r-kernels-jupyter:
	/usr/bin/R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
	library(devtools); \
	devtools::install('$$D1/opt/repositories/git-reps/IRkernel.IRkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'cran')"

	$$D1/bin/R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
	library(devtools); \
	devtools::install('$$D1/opt/repositories/git-reps/IRkernel.IRkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'local-cran')"

system-install-perl-packages:
	sudo cpan $$PERL_PACKAGES
	sudo cpanm -n $$PERL_CPANM

system-install-pip3-packages:
	for package in $$PYTHON3_PACKAGES; do \
		sudo -H pip3 install $$package --upgrade; done

	for package in $$DEV_PYTHON_PACKAGES; do \
		sudo -H pip3 install $$package --upgrade; done

system-remove-pip3-packages:
	for package in $$PYTHON3_PACKAGES; do \
		sudo -H pip3 uninstall $$package; done

	for package in $$DEV_PYTHON_PACKAGES; do \
		sudo -H pip3 uninstall $$package; done

system-install-cuda-pip3-packages:
	for package in $$CUDA_PYTHON3_PACKAGES; do \
		sudo -H pip3 install $$package --upgrade; done

system-remove-cuda-pip3-packages:
	for package in $$CUDA_PYTHON3_PACKAGES; do \
		sudo -H pip3 uninstall $$package; done

local-install-pip3-packages:
	for package in $$PYTHON3_PACKAGES; do \
		$$D1/opt/python-$$python3_v/bin/pip3 install $$package --upgrade; done

	for package in $$DEV_PYTHON_PACKAGES; do \
		$$D1/opt/python-$$python3_v/bin/pip3 install $$package --upgrade; done

local-install-cuda-pip3-packages:
	for package in $$CUDA_PYTHON3_PACKAGES; do \
		$$D1/opt/python-$$python3_v/bin/pip3 install $$package --upgrade; done

system-install-jupyter-packages:
	for package in $$JUPYTER_PACKAGES; do \
		sudo -H pip3 install $$package --upgrade; done

	# install python kernel
	/usr/bin/python3 -m ipykernel install --user
	/usr/bin/python3 -m nbopen.install_xdg

	# install and enable rise
	sudo jupyter-nbextension install rise --py --sys-prefix
	sudo jupyter-nbextension enable rise --py --sys-prefix

local-install-jupyter-packages:
	for package in $$JUPYTER_PACKAGES; do \
		$$D1/opt/python-$$python3_v/bin/pip3 install $$package --upgrade; done

	# install python kernel
	$$D1/opt/python-$$python3_v/bin/python3 -m ipykernel install --user
	$$D1/opt/python-$$python3_v/bin/python3 -m nbopen.install_xdg

	# install and enable rise
	$$D1/opt/python-$$python3_v/bin/jupyter-nbextension install rise --py --sys-prefix
	$$D1/opt/python-$$python3_v/bin/jupyter-nbextension enable rise --py --sys-prefix

# install from source python and R
.ONESHELL:
compile-python2:
	mkdir -p $$D1/opt/ubuntu-software

	wget https://www.python.org/ftp/python/$$python2_v/Python-$$python2_v.tgz \
	-O $$D1/opt/ubuntu-software/Python-$$python2_v.tgz
	if [ -d $$D1/opt/Python-$$python2_v ]; then rm -rf $$D1/opt/Python-$$python2_v; fi
	tar xvzf $$D1/opt/ubuntu-software/Python-$$python2_v.tgz -C $$D1/opt
	cd $$D1/opt/Python-$$python2_v
	if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/python-$$python2_v ]; then rm -rf $$D1/opt/python-$$python2_v; fi
	./configure --prefix=$$D1/opt/python-$$python2_v --enable-optimizations
	make
	make install

.ONESHELL:
compile-python3:
	mkdir -p $$D1/opt/ubuntu-software

	wget https://www.python.org/ftp/python/$$python3_v/Python-$$python3_v.tgz \
	-O $$D1/opt/ubuntu-software/Python-$$python3_v.tgz
	if [ -d $$D1/opt/Python-$$python3_v ]; then rm -rf $$D1/opt/Python-$$python3_v; fi
	tar xvzf $$D1/opt/ubuntu-software/Python-$$python3_v.tgz -C $$D1/opt
	cd $$D1/opt/Python-$$python3_v
	if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/python-$$python3_v ]; then rm -rf $$D1/opt/python-$$python3_v; fi
	./configure --prefix=$$D1/opt/python-$$python3_v --enable-optimizations
	make
	make install

.ONESHELL:
compile-r-cran:
	mkdir -p $$D1/opt/ubuntu-software

	wget https://cloud.r-project.org/bin/linux/ubuntu/bionic-cran35/r-base_$$r_version.orig.tar.gz \
	-O $$D1/opt/ubuntu-software/R-$$r_version.tgz
	if [ -d $$D1/opt/R-$$r_version ]; then rm -rf $$D1/opt/R-$$r_version; fi
	tar xvzf $$D1/opt/ubuntu-software/R-$$r_version.tgz -C $$D1/opt
	cd $$D1/opt/R-$$r_version
	if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/r-$$r_version ]; then rm -rf $$D1/opt/r-$$r_version; fi
	./configure --prefix=$$D1/opt/r-$$r_version --enable-R-shlib --with-blas --with-lapack
	make
	make install

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
