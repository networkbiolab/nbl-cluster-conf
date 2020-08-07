SHELL := /bin/bash
HOST=$(shell hostname)

export D1=/
export r_version=3.6.3
export bioconductor_v=3.10
export python3_v=3.8.2
export python2_v=2.7.18

# use virtual environment for anvio, symfit, libroadrunner, tensorflow-gpu because of incompatibilities
# use virtual environment for indra because downgrades pysb
export PYTHON3_PACKAGES=pip numpy pandas nose python-libsbml \
	cobra escher seaborn pillow bokeh dnaplotlib pysb \
	biopython bioservices openpyxl xlrd fastcluster scikit-bio \
	scikit-learn rpy2 tzlocal networkx cutadapt \
	distributed statsmodels biom-format \
	seqmagick pygtrie xgboost kneaddata humann2 pysundials \
	keyrings.alt dask_jobqueue scanpy louvain python-igraph \
	gprofiler-official anndata2ri fastai s-tui pythoncyc docopts deblur pyyaml

export PYTHON2_PACKAGES=pip qiime biom-format msgpack xgboost kneaddata humann2 pyyaml

export DEV_PYTHON_PACKAGES=testresources twine sphinx sphinx-autobuild \
	sphinx_rtd_theme versioneer pylint autopep8 pyscaffold

export CUDA_PYTHON3_PACKAGES=pycuda scikit-cuda \
	torch torchvision theano cntk cntk-gpu keras

export JUPYTER_PACKAGES=jupyter jupyterlab ipykernel nbopen rise nbserverproxy jupyter_nbextensions_configurator

export PERL_PACKAGES=App::cpanminus CPAN

export PERL_CPANM=App::cpanoutdated Test::Pod::Coverage JSON Math::CDF HTML::Template \
	XML::Compile::SOAP11 XML::Compile::WSDL11 XML::Compile::Transport::SOAPHTTP \
	Bio::Perl Statistics::R Bio::DB::Taxonomy XML::LibXML LWP::Simple Text::CSV \
	JSON File::Slurp XML::DOM::XPath GD App::Cmd::Setup Bio::Roary

export PERL_RSAT=Algorithm::Cluster Bio::Das Bio::Perl CGI Class::Std::Fast DBD::mysql DBI \
	DB_File Data::Dumper Digest::MD5::File Email::Sender \
	Email::Sender::Transport::SMTPS Email::Simple Email::Simple::Creator File::Spec \
	GD HTTP::Tiny IO::All JSON LWP::Simple LWP::UserAgent LockFile::Simple \
	Log::Log4perl MCE::Shared Math::CDF Module::Build::Compat Number::Format \
	OLE::Storage_Lite Object::InsideOut Util::Properties POSIX Parallel::ForkManager \
	PostScript::Simple REST::Client Readonly SOAP::Lite SOAP::Packager \
	SOAP::Transport::HTTP SOAP::WSDL Spreadsheet::WriteExcel \
	Spreadsheet::WriteExcel::Big Statistics::Distributions \
	Template::Plugin::Number::Format XML::Compile XML::Compile::Cache \
	XML::Compile::SOAP11 XML::Compile::Transport::SOAPHTTP XML::Compile::WSDL11 \
	XML::DOM XML::LibXML XML::LibXML::Simple XML::Parser::Expat YAML

export R_PACKAGES=Rcpp tidyverse knitr rmarkdown gridExtra plotly Cairo ggpubr ape \
	optparse RColorBrewer randomForest vegan apcluster chron compare compute.es \
	d3heatmap dendextend DEoptimR diptest fastmatch flexmix fpc kernlab mclust mds \
	modeltools mvtnorm NLP phangorn pheatmap plotrix PMCMRplus png prabclus \
	qdapDictionaries qdapRegex quadprog rafalib reports robustbase rvcheck segmented \
	seqinr slam tidytree trimcluster UpSetR wordcloud freetypeharfbuzz EQUIVNONINF \
	xgboost ROCR ggplot2 clusterSim splines stats4 survival mvtnorm modeltools coin MASS

export R_OLD2INSTALL=biom

export BIOCONDUCTOR=gam clusterExperiment dada2 edgeR phyloseq DESeq DESeq2 microbiome \
	BiocVersion ggtree graph hypergraph treeio metagenomeSeq SIAMCAT \
	cluster EnhancedVolcano zinbwave scran MAST monocle \
	ComplexHeatmap slingshot

.ONESHELL:
test:
	echo $(HOME)
	echo $$(which pip3)
	echo $(HOST)

# libcurl4-openssl-dev incompatible with libstaden-read-dev
# fastx-toolkit, gir1.2-networkmanager-1.0, qiime, sra-toolkit, tophat not available ubuntu 20.04
.ONESHELL:
apt-install:
	APTS="ant apache2 apt-file aptitude artemis auditd augustus autoconf bamtools baobab \
		barrnap bcftools bedops bedtools biom-format-tools bioperl bison bowtie bowtie2 \
		bwa capnproto cargo cd-hit chrome-gnome-shell clustalx cmake cufflinks curl \
		cutadapt cython dejagnu diamond-aligner disper docker.io doxygen ea-utils emboss \
		expat fastqc fasttree ffmpeg flex freeipmi g++ ganglia-monitor \
		ganglia-webfrontend gcc gettext gfortran ghostscript gimp gir1.2-clutter-1.0 \
		gir1.2-gtop-2.0 gmetad gnome-core gnome-devel \
		gnome-themes-standard gnome-tweak-tool gparted gperf gzip hddtemp help2man \
		hisat2 hmmer htop hwloc idba infernal inkscape intltool julia junit kallisto \
		kate kmc kompare kraken lammps lftp libapache2-mod-php7.4 libargtable2-dev \
		libatlas-base-dev libblas-dev libboost-all-dev libcanberra-gtk3-module \
		libcanberra-gtk-module libcereal-dev libcerf-dev  \
		libdist-zilla-perl libdivsufsort-dev libdrm-dev libeigen3-dev libfile-slurp-perl \
		libfreeipmi-dev libgdal-dev libgd-dev libgirepository1.0-dev libglfw3-dev \
		libglu1-mesa-dev libgmp-dev libgoogle-perftools-dev libgsl-dev libgtk2.0-dev \
		libhdf5-serial-dev libhmsbeagle-dev libhpdf-dev libhts-dev libhttp-parser-dev \
		libhwloc-dev libibmad-dev libidn11-dev libipmimonitoring-dev libjansson-dev \
		libjemalloc1 libjemalloc-dev libjson-perl libjwt-dev libkrb5-dev liblapack-dev \
		liblapacke liblmdb-dev liblpsolve55-dev liblua50-dev liblua5.1-0-dev \
		liblua5.2-dev liblua5.3-dev liblwp-protocol-https-perl libmagick++-dev \
		libmetis-dev libmpfr-dev libmunge-dev libnlopt-dev libopenblas-dev \
		libopenmpi-dev libpam0g-dev libpciaccess-dev libpmix-dev libreoffice librrd-dev \
		libsndfile1-dev libsparsehash-dev libstaden-read-dev libsundials-dev libtbb-dev \
		libtext-csv-perl libtool libudunits2-dev libwww-perl libxm4 libxslt1-dev \
		libyaml-dev llvm-dev lm-sensors mafft mailutils man2html mash maven mcl \
		mesa-common-dev mira-assembler mlocate mrbayes nagios3 nasm ncbi-blast+ \
		net-tools nfs-common nfs-kernel-server nginx nodejs npm numactl nvidia-cuda-dev \
		nvidia-cuda-doc nvidia-cuda-gdb nvidia-cuda-toolkit ocamlbuild opam \
		openjdk-11-jdk-headless openjdk-8-jdk openjdk-8-jre openssh-server pandoc \
		parallel pdfshuffler pdsh php7.4 php7.4-cli php7.4-common php7.4-curl php7.4-gd \
		php7.4-gmp php7.4-intl php7.4-mbstring php7.4-mysql php7.4-xml php7.4-xmlrpc \
		php7.4-zip postfix prodigal python3-opencv python3-pip python3-tk python-pip \
		python-tk rar r-base rename repeatmasker-recon rrdtool rubber ruby salmon \
		samtools sbmltoolbox smartmontools smem snap snap-aligner soapdenovo2 spades \
		speedtest-cli sqlite sqlite3 sshfs swig synaptic systemtap tabix \
		testssl.sh trimmomatic trnascan-se ttf-mscorefonts-installer \
		ubuntu-server unzip vagrant velvet virtualbox vlc vsearch wakeonlan x11-utils \
		zlib1g zlib1g-dev zlibc gnome-shell-extensions gradle hhsuite golang-go sortmerna tilix"

	PYTHON3_DEPS="python3-pip python3-tk python3-h5py build-essential \
		checkinstall libssl-dev zlib1g-dev libncurses5-dev \
		libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
		libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev uuid-dev"

	R_DEPS="libcairo2-dev libxt-dev libtiff5-dev libssh2-1-dev libxml2 libxml2-dev"

	apt-get update
	apt-get -y upgrade
	apt-get -y dist-upgrade

	RED=$(tput setaf 1)
	for apt in $$APTS; do printf "\\n %s\\n" "Installing $${apt}";
		apt-get -y install $$apt; done
	for apt in $$PYTHON3_DEPS; do printf "\\n %s\\n" "Installing $${apt}";
		apt-get -y install $$apt; done
	for apt in $$R_DEPS; do printf "\\n %s\\n" "Installing $${apt}";
		apt-get -y install $$apt; done

	apt-get -y remove xul-ext-ubufox gedit
	apt-get -y autoremove
	apt-get -y autoclean
	apt-get -y clean

latex-install:
	apt-get -y install texstudio texlive-full

# only ubuntu 18.04
cuda-download:
	cd $$D1/opt/ubuntu-software
	wget --continue https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
	wget --continue https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb

# only ubuntu 18.4
cuda-install:
	cd $$D1/opt/ubuntu-software

	apt-get -y install linux-headers-$(uname -r)
	cp cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600

	dpkg -i cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
	apt-key add /var/cuda-repo-10-2-local-10.2.89-440.33.01/7fa2af80.pub
	apt-get update
	apt-get -y install cuda

.ONESHELL:
local-install-rpackages:
	# install R packages
	for package in $$R_PACKAGES; do $$D1/opt/R-$$r_version/bin/R -e \
		"options(Ncpus = 8); install.packages('$$package', dependencies = TRUE, repos = 'https://cloud.r-project.org/')"; done

.ONESHELL:
local-install-bioconductor:
	# install Bioconductor packages
	$$D1/opt/R-$$r_version/bin/R -e \
		"options(Ncpus = 8); install.packages(\"BiocManager\", \
		dependencies = TRUE, repos = 'https://cloud.r-project.org/', update = TRUE, ask = FALSE)"
	for package in $$BIOCONDUCTOR; do $$D1/opt/R-$$r_version/bin/R -e \
		"options(Ncpus = 8); BiocManager::install(\"$$package\", version = \"$$bioconductor_v\")"; done

.ONESHELL:
system-install-rpackages:
	# install R packages
	for package in $$R_PACKAGES; do R -e \
		"options(Ncpus = 8); install.packages('$$package', dependencies = TRUE, repos = 'https://cloud.r-project.org/')"; done

.ONESHELL:
system-install-bioconductor:
	# install Bioconductor packages
	R -e "options(Ncpus = 8); install.packages(\"BiocManager\", dependencies = TRUE, repos = 'https://cloud.r-project.org/', update = TRUE, ask = FALSE)"
	for package in $$BIOCONDUCTOR; do R -e "options(Ncpus = 8); BiocManager::install(\"$$package\", version = \"$$bioconductor_v\")"; done

.ONESHELL:
test-rpackages:
	for package in $$R_PACKAGES; do printf "\\n %s\\n" "Testing $${package}...";
		R -e "library('$$package')" 2> out 1> /dev/null; grep "there is no package called" out; rm out; done

.ONESHELL:
test-bioconductor:
	for package in $$BIOCONDUCTOR; do printf "\\n %s\\n" "Testing $${package}...";
		R -e "library('$$package')" 2> out 1> /dev/null; grep "there is no package called" out; rm out; done

.ONESHELL:
jupyter-r-kernel:
	R -e "options(Ncpus = 8); \
	install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
	library(devtools); \
	devtools::install('$$D1/opt/repositories/git-reps/IRkernel.IRkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'cran')"

# 	$$D1/opt/R-$$r_version/bin/R -e "options(Ncpus = 8); \
# 	install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
# 	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
# 	library(devtools); \
# 	devtools::install('$$D1/opt/repositories/git-reps/IRkernel.IRkernel/R'); \
# 	library(IRkernel); \
# 	IRkernel::installspec(name = 'R-$$r_version-local')"

.ONESHELL:
system-install-perl-packages:
	cpan $$PERL_PACKAGES
	cpanm -n $$PERL_CPANM
	cpanm -n $$PERL_RSAT

.ONESHELL:
system-install-pip3-packages:
	for package in $$PYTHON3_PACKAGES; do \
		python3 -m pip install $$package --upgrade; done

	for package in $$DEV_PYTHON_PACKAGES; do \
		python3 -m pip install $$package --upgrade; done

.ONESHELL:
system-remove-pip3-packages:
	for package in $$PYTHON3_PACKAGES; do \
		python3 -m pip uninstall $$package; done

	for package in $$DEV_PYTHON_PACKAGES; do \
		python3 -m pip uninstall $$package; done

.ONESHELL:
system-install-cuda-pip3-packages:
	for package in $$CUDA_PYTHON3_PACKAGES; do \
		python3 -m pip install $$package --upgrade; done

.ONESHELL:
system-remove-cuda-pip3-packages:
	for package in $$CUDA_PYTHON3_PACKAGES; do \
		python3 -m pip uninstall $$package; done

.ONESHELL:
local-install-pip3-packages:
	for package in $$PYTHON3_PACKAGES; do \
		$$D1/opt/python-$$python3_v/bin/python3 -m pip install $$package --upgrade; done

	for package in $$DEV_PYTHON_PACKAGES; do \
		$$D1/opt/python-$$python3_v/bin/python3 -m pip install $$package --upgrade; done

.ONESHELL:
local-install-cuda-pip3-packages:
	for package in $$CUDA_PYTHON3_PACKAGES; do \
		$$D1/opt/python-$$python3_v/bin/python3 -m pip install $$package --upgrade; done

.ONESHELL:
system-install-jupyter-packages:
	for package in $$JUPYTER_PACKAGES; do \
		python3 -m pip install $$package --upgrade; done

	# install python kernel
	python3 -m ipykernel install --user
	python3 -m nbopen.install_xdg

	# install and enable rise
	jupyter-nbextension install rise --py --sys-prefix
	jupyter-nbextension enable rise --py --sys-prefix

.ONESHELL:
local-install-jupyter-packages:
	for package in $$JUPYTER_PACKAGES; do \
		$$D1/opt/python-$$python3_v/bin/python3 -m pip install $$package --upgrade; done

	# install python kernel
	$$D1/opt/python-$$python3_v/bin/python3 -m ipykernel install --user
	$$D1/opt/python-$$python3_v/bin/python3 -m nbopen.install_xdg

	# install and enable rise
	$$D1/opt/python-$$python3_v/bin/jupyter-nbextension install rise --py --sys-prefix
	$$D1/opt/python-$$python3_v/bin/jupyter-nbextension enable rise --py --sys-prefix

# install python and R from source
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
	./configure --prefix=$$D1/opt/python-$$python2_v --with-ensurepip=install
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
	./configure --prefix=$$D1/opt/python-$$python3_v --with-ensurepip=install
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
	./configure --prefix=$$D1/opt/r-$$r_version --enable-R-shlib --enable-R-static-lib --with-blas --with-lapack
	make
	make install

.ONESHELL:
slurm-install:
	apt-get -y remove --purge munge slurm-wlm slurmdbd
	apt-get -y autoremove
	apt-get -y install munge slurm-wlm slurmdbd

.ONESHELL:
slurm-conf:
	systemctl stop munge
	systemctl stop slurmd

	if [[ "$(HOST)" == "nbl1" ]] ; then
		systemctl stop slurmctld
		systemctl stop slurmdbd
	fi

	rm -rf /var/lib/slurm-llnl /var/run/slurm-llnl /var/log/slurm-llnl

	mkdir -p /var/spool/slurmd
	mkdir -p /var/lib/slurm-llnl
	mkdir -p /var/lib/slurm-llnl/slurmd
	mkdir -p /var/lib/slurm-llnl/slurmctld
	mkdir -p /var/run/slurm-llnl
	mkdir -p /var/log/slurm-llnl

	chmod -R 755 /var/spool/slurmd
	chmod -R 755 /var/lib/slurm-llnl/
	chmod -R 755 /var/run/slurm-llnl/
	chmod -R 755 /var/log/slurm-llnl/

	chown -R slurm:slurm /var/spool/slurmd
	chown -R slurm:slurm /var/lib/slurm-llnl/
	chown -R slurm:slurm /var/run/slurm-llnl/
	chown -R slurm:slurm /var/log/slurm-llnl/

	cp slurm.conf gres.conf /etc/slurm-llnl/

	if [[ "$(HOST)" == "nbl1" ]] ; then
		dd if=/dev/urandom bs=1 count=1024 > ./munge.key
	fi

	rsync -avu -P munge.key /etc/munge/munge.key
	chown munge:munge /etc/munge/munge.key
	chmod 400 /etc/munge/munge.key
	chmod 711 /var/lib/munge/
	chmod 755 /var/run/munge/

	systemctl restart munge
	service munge status

	systemctl restart slurmd
	service slurmd status

	if [[ "$(HOST)" == "nbl1" ]] ; then
		systemctl restart slurmctld
		service slurmctld status
	else
		systemctl stop slurmctld
		service slurmctld status
	fi
