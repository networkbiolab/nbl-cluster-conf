SHELL := /bin/bash
HOST=$(shell hostname)

export D1=/home
export r4_version=4.0.2
export r3_version=3.6.3
export bioconductor_r4_v=3.11
export bioconductor_r3_v=3.10
export python3_v=3.8.5
export python2_v=2.7.18
export perl_v=5.32.0

export all_python3_v=3.4.10 3.5.10 3.6.12 3.7.9
#3.3.7 3.2.6 3.1.5 3.0.1
export all_python2_v=2.6.9 2.5.4 2.4.4 2.3.5 2.2.3 2.1.3 2.0.1
export all_r4_versions=4.0.1 4.0.0
export all_r3_versions=3.5.3 3.4.4 3.3.3 3.2.5 3.1.3 3.0.3

# use virtual environment for anvio, symfit, libroadrunner, tensorflow-gpu because of incompatibilities
# use virtual environment for indra because downgrades pysb
export PYTHON3_PACKAGES=pip wheel numpy cython futures \
	anndata2ri biom-format biopython bioservices bokeh checkm-genome cobra cogent3 \
	cutadapt dask_jobqueue deblur distributed dnaplotlib docopts escher fastai \
	fastcluster fsspec gprofiler-official humann2 keyrings.alt kneaddata louvain \
	networkx nose openpyxl pandas pillow pybedtools pygraphviz pygtrie pysb \
	pysundials pythoncyc python-igraph python-libsbml pyyaml rpy2 scanpy scikit-bio \
	scikit-image scikit-learn seaborn seqmagick snakeviz statsmodels s-tui tzlocal \
	xgboost xlrd \
	pysam htseq macs2 deeptools micca htsget pyega3

# biom-format not supported for python2.7
export PYTHON2_PACKAGES=pip wheel numpy cython futures \
	bcbio-gff "biopython==1.76" funannotate humann2 keras kneaddata \
	markdown2 matplotlib msgpack networkx parmap pybedtools pybigwig pydnase pyfasta \
	pyyaml qiime xgboost htseq

export DEV_PYTHON_PACKAGES=autopep8 pylint pyscaffold sphinx sphinx-autobuild sphinx_rtd_theme testresources twine versioneer

export CUDA_PYTHON3_PACKAGES=cntk cntk-gpu keras pycuda scikit-cuda theano torch torchvision

export JUPYTER_PACKAGES=ipykernel jupyter jupyterlab jupyter_nbextensions_configurator nbopen nbserverproxy rise

export PERL_PACKAGES=App::cpanminus CPAN

export PERL_CPANM=App::Cmd::Setup App::cpanoutdated Bio::DB::Taxonomy Bio::Perl Bio::Roary \
	Bit::Vector CGI::Session CGI::Session::Driver::db_file Data::Dumper DBD::Pg \
	DBD::SQLite experimental File::Slurp File::Spec forks forks::shared GD \
	Getopt::Long Hash::Merge HTML::Template Inline::C JSON List::Util Logger::Simple \
	LWP::Simple Mail::Mailer Math::CDF Parallel::ForkManager PDF::API2 \
	Perl::Unsafe::Signals Scalar::Util Statistics::R SVG Test::Pod::Coverage \
	Text::CSV Try::Tiny Want XML::Compile::SOAP11 XML::Compile::Transport::SOAPHTTP \
	XML::Compile::WSDL11 XML::DOM::XPath XML::LibXML XML::Simple \
	Alien::Build Log::Log4perl YAML PAR::Dist CPAN::DistnameInfo inc::latest Module::Build Set::IntervalTree DBI DB_File URI Archive::Zip Set::IntervalTree PerlIO::gzip Bio::DB::BigFile

export PERL_RSAT=Algorithm::Cluster Bio::Das Bio::Perl CGI Class::Std::Fast Data::Dumper \
	DBD::mysql DB_File DBI Digest::MD5::File Email::Sender \
	Email::Sender::Transport::SMTPS Email::Simple Email::Simple::Creator File::Spec \
	GD HTTP::Tiny IO::All JSON LockFile::Simple Log::Log4perl LWP::Simple \
	LWP::UserAgent Math::CDF MCE::Shared Module::Build::Compat Number::Format \
	Object::InsideOut OLE::Storage_Lite Parallel::ForkManager POSIX \
	PostScript::Simple Readonly REST::Client SOAP::Lite SOAP::Packager \
	SOAP::Transport::HTTP SOAP::WSDL Spreadsheet::WriteExcel \
	Spreadsheet::WriteExcel::Big Statistics::Distributions \
	Template::Plugin::Number::Format Util::Properties XML::Compile \
	XML::Compile::Cache XML::Compile::SOAP11 XML::Compile::Transport::SOAPHTTP \
	XML::Compile::WSDL11 XML::DOM XML::LibXML XML::LibXML::Simple XML::Parser::Expat \
	YAML

export R_PACKAGES=apcluster ape Cairo chron clusterSim coin compare compute.es data.table \
	dendextend DEoptimR diptest EQUIVNONINF fastmatch flexmix fpc freetypeharfbuzz \
	ggplot2 ggpubr gridExtra jsonlite kernlab knitr MASS mclust mds modeltools \
	mvtnorm NLP optparse phangorn pheatmap plotly plotrix PMCMRplus png prabclus \
	pROC qdapDictionaries qdapRegex quadprog rafalib randomForest RColorBrewer Rcpp \
	RCurl rgl rmarkdown robustbase ROCR rvcheck segmented seqinr slam survival \
	tidytree tidyverse trimcluster tsne UpSetR vegan wordcloud xgboost XML WGCNA \
	mclust PSCBS R.cache scales cwhmisc fastICA digest

export R_OLD2INSTALL=biom reports d3heatmap

export BIOCONDUCTOR=BiocVersion cluster clusterExperiment ComplexHeatmap dada2 DESeq DESeq2 edgeR \
	EnhancedVolcano gam GenomicAlignments GenomicFeatures ggtree GOstats graph \
	hypergraph kebabs MAST metagenomeSeq microbiome monocle phyloseq scran SIAMCAT \
	slingshot treeio vsn zinbwave dorothea impute DNAcopy aroma.light

.ONESHELL:
test:
	echo $(HOME)
	echo $$(which pip3)
	echo $(HOST)

# libcurl4-openssl-dev incompatible with libstaden-read-dev
# gnome-core is removed along with gedit
# disper, fastx-toolkit, gir1.2-networkmanager-1.0, python-pip, qiime, sra-toolkit, tophat not available ubuntu 20.04
.ONESHELL:
apt-install:
	APTS="ant apache2 apt-file aptitude artemis auditd augustus autoconf bamtools baobab \
		barrnap bcftools bedops bedtools biom-format-tools bioperl bison bowtie bowtie2 \
		bwa capnproto cargo cd-hit chrome-gnome-shell clustalx cmake cufflinks curl \
		cutadapt cython dejagnu diamond-aligner docker.io doxygen ea-utils emboss \
		environment-modules expat fastqc fasttree ffmpeg flex freeipmi g++ \
		ganglia-monitor ganglia-webfrontend gcc gettext gfortran ghostscript gimp \
		gir1.2-clutter-1.0 gir1.2-gtop-2.0 gmetad gnome-devel gnome-shell-extensions \
		gnome-themes-standard gnome-tweak-tool golang-go gparted gperf gradle gzip \
		hddtemp help2man hhsuite hisat2 hmmer htop hwloc idba infernal inkscape intltool \
		julia junit kallisto kate kmc kompare kraken lammps lftp libapache2-mod-php7.4 \
		libargtable2-dev libatlas-base-dev libblas-dev libboost-all-dev \
		libcanberra-gtk3-module libcanberra-gtk-module libcereal-dev libcerf-dev \
		libdist-zilla-perl libdivsufsort-dev libdrm-dev libeigen3-dev libfile-slurp-perl \
		libfreeipmi-dev libgdal-dev libgd-dev libgirepository1.0-dev libglfw3-dev \
		libglu1-mesa-dev libgmp-dev libgoogle-perftools-dev libgraphviz-dev libgsl-dev \
		libgtk2.0-dev libhdf5-serial-dev libhmsbeagle-dev libhpdf-dev libhts-dev \
		libhttp-parser-dev libhwloc-dev libibmad-dev libidn11-dev libipmimonitoring-dev \
		libjansson-dev libjemalloc2 libjemalloc-dev libjson-perl libjwt-dev libkrb5-dev \
		liblapack-dev liblapacke liblmdb-dev liblpsolve55-dev liblua50-dev \
		liblua5.1-0-dev liblua5.2-dev liblua5.3-dev liblwp-protocol-https-perl \
		libmagick++-dev libmetis-dev libmpfr-dev libmunge-dev libnlopt-dev \
		libopenblas-dev libopenmpi-dev libpam0g-dev libpciaccess-dev libpmix-dev \
		libreoffice librrd-dev libsndfile1-dev libsparsehash-dev libstaden-read-dev \
		libsundials-dev libtbb-dev libtext-csv-perl libtool libudunits2-dev libwww-perl \
		libxm4 libxslt1-dev libyaml-dev llvm-dev lm-sensors mafft mailutils man2html \
		mash maven mcl mesa-common-dev mira-assembler mlocate mrbayes nagios4 nasm \
		ncbi-blast+ net-tools nfs-common nfs-kernel-server nginx nodejs npm numactl \
		nvidia-cuda-dev nvidia-cuda-doc nvidia-cuda-gdb nvidia-cuda-toolkit ocamlbuild \
		opam openjdk-11-jdk-headless openjdk-8-jdk openjdk-8-jre openssh-server pandoc \
		parallel pdfshuffler pdsh php7.4 php7.4-cli php7.4-common php7.4-curl php7.4-gd \
		php7.4-gmp php7.4-intl php7.4-mbstring php7.4-mysql php7.4-xml php7.4-xmlrpc \
		php7.4-zip postfix prodigal python3-opencv python3-pip python3-tk python3-venv \
		python-pip-whl python-tk rar r-base rename repeatmasker-recon rrdtool rubber \
		ruby salmon samtools sbmltoolbox smartmontools smem snap snap-aligner \
		soapdenovo2 sortmerna spades speedtest-cli sqlite sqlite3 sshfs swig synaptic \
		systemtap tabix testssl.sh tilix trimmomatic trnascan-se \
		ttf-mscorefonts-installer ubuntu-server unzip vagrant velvet virtualbox vlc \
		vsearch wakeonlan x11-utils zlib1g zlib1g-dev zlibc iqtree clang-tidy libpll-dev awscli vcftools git-lfs lolcat cowsay fortune"

	PYTHON3_DEPS="python3-pip python3-tk python3-h5py build-essential \
		checkinstall libssl-dev zlib1g-dev libncurses5-dev \
		libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
		libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev uuid-dev"

	R_DEPS="libcairo2-dev libxt-dev libtiff5-dev libssh2-1-dev libxml2 libxml2-dev"

	apt-get update
	apt-get -y upgrade
	apt-get -y dist-upgrade

	for apt in $$APTS; do
		printf "\\n %s\\n" "Installing $${apt}";
		apt-get -y install $$apt; done
	for apt in $$PYTHON3_DEPS; do
		printf "\\n %s\\n" "Installing $${apt}";
		apt-get -y install $$apt; done
	for apt in $$R_DEPS; do
		printf "\\n %s\\n" "Installing $${apt}";
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

define install_cran_packages
	for package in $$R_PACKAGES; do
		$(1) -e "options(Ncpus = 8); install.packages('$$package', dependencies = TRUE, repos = 'https://cloud.r-project.org/')";
	done
endef

.ONESHELL:
system-install-cran-packages:
	$(call install_cran_packages,R)

.ONESHELL:
local-install-r3-packages:
	$(call install_cran_packages,$$D1/opt/r-$$r3_version/bin/R)

.ONESHELL:
all-local-install-r3-packages:
	for version in $$all_r3_versions; do
		export r3_version=$$version
		$(call install_cran_packages,$$D1/opt/r-$$r3_version/bin/R)
	done

.ONESHELL:
local-install-r4-packages:
	$(call install_cran_packages,$$D1/opt/r-$$r4_version/bin/R)

.ONESHELL:
all-local-install-r4-packages:
	for version in $$all_r4_versions; do
		export r4_version=$$version
		$(call install_cran_packages,$$D1/opt/r-$$r4_version/bin/R)
	done

define install_bioconductor_packages
	$(1) -e "options(Ncpus = 8); install.packages('BiocManager', dependencies = TRUE, repos = 'https://cloud.r-project.org/', update = TRUE, ask = FALSE)"
	for package in $$BIOCONDUCTOR; do
		$(1) -e "options(Ncpus = 8); BiocManager::install(\"$$package\", version = \"$(2)\")";
	done
endef

.ONESHELL:
system-install-bioconductor-packages:
	$(call install_bioconductor_packages,R)

.ONESHELL:
local-install-bioconductor-r3-packages:
	$(call install_bioconductor_packages,$$D1/opt/r-$$r3_version/bin/R,$$bioconductor_r3_v)

.ONESHELL:
all-local-install-bioconductor-r3-packages:
	for version in $$all_r3_versions; do
		export r3_version=$$version
		if [ "$$version" = "3.5.3" ]; then
			$(call install_bioconductor_packages,$$D1/opt/r-$$r3_version/bin/R,3.8)
		elif [ "$$version" = "3.4.4" ]; then
			$(call install_bioconductor_packages,$$D1/opt/r-$$r3_version/bin/R,3.6)
		elif [ "$$version" = "3.3.3" ]; then
			$(call install_bioconductor_packages,$$D1/opt/r-$$r3_version/bin/R,3.4)
		elif [ "$$version" = "3.2.5" ]; then
			$(call install_bioconductor_packages,$$D1/opt/r-$$r3_version/bin/R,3.2)
		elif [ "$$version" = "3.1.3" ]; then
			$(call install_bioconductor_packages,$$D1/opt/r-$$r3_version/bin/R,3.0)
		elif [ "$$version" = "3.0.3" ]; then
			$(call install_bioconductor_packages,$$D1/opt/r-$$r3_version/bin/R,2.13)
		fi
	done

.ONESHELL:
local-install-bioconductor-r4-packages:
	$(call install_bioconductor_packages,$$D1/opt/r-$$r4_version/bin/R,$$bioconductor_r4_v)

.ONESHELL:
all-local-install-bioconductor-r4-packages:
	for version in $$all_r4_versions; do
		export r4_version=$$version
		elif [ "$$version" = "4.0.1" ]; then
			$(call install_bioconductor_packages,$$D1/opt/r-$$r4_version/bin/R,3.11)
		elif [ "$$version" = "4.0.0" ]; then
			$(call install_bioconductor_packages,$$D1/opt/r-$$r4_version/bin/R,3.11)
		fi
	done

define test_packages:
	for package in $(1); do
		printf "\\n %s\\n" "Testing $${package}...";
		$(2) -e "library('$$package')" 2> out 1> /dev/null;
		grep "there is no package called" out;
		rm out;
		done
endef

.ONESHELL:
test-system-cran-packages:
	$(call test_packages,$$R_PACKAGES,R)

.ONESHELL:
test-system-bioconductor-packages:
	$(call test_packages,$$BIOCONDUCTOR,R)

.ONESHELL:
test-local-cran-packages:
	$(call test_packages,$$R_PACKAGES,$$D1/opt/r-$$r_version/bin/R)

.ONESHELL:
test-local-bioconductor-packages:
	$(call test_packages,$$BIOCONDUCTOR,$$D1/opt/r-$$r_version/bin/R)

.ONESHELL:
system-jupyter-r-kernel:
	R -e "options(Ncpus = 8); \
	install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
	library(devtools); \
	devtools::install('$$D1/opt/repositories/git-reps/IRkernel.IRkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'cran')"

.ONESHELL:
local-jupyter-r-kernel:
	$$D1/opt/R-$$r_version/bin/R -e "options(Ncpus = 8); \
	install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
	library(devtools); \
	devtools::install('$$D1/opt/repositories/git-reps/IRkernel.IRkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'R-$$r_version-local')"

define install_perl_packages
	$(1)cpan $$PERL_PACKAGES
	$(1)cpanm -n $$PERL_CPANM
	$(1)cpanm -n $$PERL_RSAT
endef

.ONESHELL:
system-install-perl-packages:
	$(call install_perl_packages,)

.ONESHELL:
local-install-perl-packages:
	$(call install_perl_packages,$$D1/opt/perl-$$perl_v/bin/)

define install_python_packages
	for package in $(1); do
		$(2) -m pip install $$package --upgrade;
	done
endef

.ONESHELL:
local-install-pip2-packages:
	$(call install_python_packages,$$PYTHON2_PACKAGES,$$D1/opt/python-$$python2_v/bin/python)

.ONESHELL:
system-install-pip3-packages:
	$(call install_python_packages,$$PYTHON3_PACKAGES,python3)
	$(call install_python_packages,$$DEV_PYTHON_PACKAGES,python3)

.ONESHELL:
local-install-pip3-packages:
	$(call install_python_packages,$$PYTHON3_PACKAGES,$$D1/opt/python-$$python3_v/bin/python3)
	$(call install_python_packages,$$DEV_PYTHON_PACKAGES,$$D1/opt/python-$$python3_v/bin/python3)

.ONESHELL:
all-local-install-pip3-packages:
	for version in $$all_python3_v; do
		export python3_v=$$version
		$(call install_python_packages,$$PYTHON3_PACKAGES,$$D1/opt/python-$$python3_v/bin/python3)
		$(call install_python_packages,$$DEV_PYTHON_PACKAGES,$$D1/opt/python-$$python3_v/bin/python3)
	done

.ONESHELL:
system-install-cuda-pip3-packages:
	$(call install_python_packages,$$CUDA_PYTHON3_PACKAGES,python3)

.ONESHELL:
local-install-cuda-pip3-packages:
	$(call install_python_packages,$$CUDA_PYTHON3_PACKAGES,$$D1/opt/python-$$python3_v/bin/python3)
	done

.ONESHELL:
all-local-install-cuda-pip3-packages:
	for version in $$all_python3_v; do
		export python3_v=$$version
		$(call install_python_packages,$$CUDA_PYTHON3_PACKAGES,$$D1/opt/python-$$python3_v/bin/python3)
	done

define remove_python_packages
	for package in $(1); do
		$(2) -m pip uninstall $$package;
	done
endef

.ONESHELL:
system-remove-pip3-packages:
	$(call remove_python_packages,$$PYTHON3_PACKAGES,python3)
	$(call remove_python_packages,$$DEV_PYTHON_PACKAGES,python3)

.ONESHELL:
local-remove-pip3-packages:
	$(call remove_python_packages,$$PYTHON3_PACKAGES,$$D1/opt/python-$$python3_v/bin/python3)
	$(call remove_python_packages,$$DEV_PYTHON_PACKAGES,$$D1/opt/python-$$python3_v/bin/python3)

.ONESHELL:
all-local-remove-pip3-packages:
	for version in $$all_python3_v; do
		export python3_v=$$version
		$(call remove_python_packages,$$PYTHON3_PACKAGES,$$D1/opt/python-$$python3_v/bin/python3)
		$(call remove_python_packages,$$DEV_PYTHON_PACKAGES,$$D1/opt/python-$$python3_v/bin/python3)
	done

define jupyter
	# install python kernel
	$(1) -m ipykernel install --user
	$(1) -m nbopen.install_xdg

	# install and enable rise
	$(2) install rise --py --sys-prefix
	$(2) enable rise --py --sys-prefix
endef

.ONESHELL:
system-install-jupyter-packages:
	$(call install_python_packages,$$JUPYTER_PACKAGES,python3)
	$(call jupyter,python3,jupyter-nbextension)

.ONESHELL:
local-install-jupyter-packages:
	$(call install_python_packages,$$JUPYTER_PACKAGES,$$D1/opt/python-$$python3_v/bin/python3)
	$(call jupyter,$$D1/opt/python-$$python3_v/bin/python3,$$D1/opt/python-$$python3_v/bin/jupyter-nbextension)

define compile_python
	mkdir -p $$D1/opt/ubuntu-software

	wget https://www.python.org/ftp/python/$(1)/Python-$(1).tgz -O $$D1/opt/ubuntu-software/Python-$(1).tgz
	if [ -d $$D1/opt/Python-$(1) ]; then rm -rf $$D1/opt/Python-$(1); fi
	tar xvzf $$D1/opt/ubuntu-software/Python-$(1).tgz -C $$D1/opt
	cd $$D1/opt/Python-$(1)
	#if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/python-$(1) ]; then rm -rf $$D1/opt/python-$(1); fi
	./configure --prefix=$$D1/opt/python-$(1) --with-ensurepip=install
	make
	make install
	rm -rf $$D1/opt/Python-$(1)
endef

.ONESHELL:
compile-python2:
	$(call compile_python,$$python2_v)

.ONESHELL:
all-compile-python2:
	for version in $$all_python2_v; do
		export python2_v=$$version
		echo $$python2_v
		$(call compile_python,$$python2_v)
	done

.ONESHELL:
compile-python3:
	$(call compile_python,$$python3_v)

.ONESHELL:
all-compile-python3:
	for version in $$all_python3_v; do
		export python3_v=$$version
		$(call compile_python,$$python3_v)
	done

define compile_r
	mkdir -p $$D1/opt/ubuntu-software

	wget https://cran.r-project.org/src/base/$(1)/R-$(2).tar.gz -O $$D1/opt/ubuntu-software/R-$(2).tgz
	if [ -d $$D1/opt/R-$(2) ]; then rm -rf $$D1/opt/R-$(2); fi
	tar xvzf $$D1/opt/ubuntu-software/R-$(2).tgz -C $$D1/opt
	cd $$D1/opt/R-$(2)
	#if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/r-$(2) ]; then rm -rf $$D1/opt/r-$(2); fi
	./configure --prefix=$$D1/opt/r-$(2) --enable-R-shlib --enable-R-static-lib --with-blas --with-lapack
	make
	make install
	rm -rf $$D1/opt/R-$(2)
endef

.ONESHELL:
compile-r4-cran:
	$(call compile_r,R-4,$$r4_version)

.ONESHELL:
all-compile-r4-cran:
	for version in $$all_r4_versions; do
		export r4_version=$$version
		$(call compile_r,R-4,$$r4_version)
	done

.ONESHELL:
compile-r3-cran:
	$(call compile_r,R-3,$$r3_version)

.ONESHELL:
all-compile-r3-cran:
	for version in $$all_r3_versions; do
		export r3_version=$$version
		$(call compile_r,R-3,$$r3_version)
	done

define compile_perl
	mkdir -p $$D1/opt/ubuntu-software

	wget https://www.cpan.org/src/5.0/perl-$(1).tar.gz -O $$D1/opt/ubuntu-software/PERL-$(1).tgz
	if [ -d $$D1/opt/PERL-$(1) ]; then rm -rf $$D1/opt/PERL-$(1); fi
	tar xvzf $$D1/opt/ubuntu-software/PERL-$(1).tgz -C $$D1/opt
	mv $$D1/opt/perl-$(1) $$D1/opt/PERL-$(1)
	cd $$D1/opt/PERL-$(1)
	#if [ -f Makefile ]; then make clean; fi
	if [ -d $$D1/opt/perl-$(1) ]; then rm -rf $$D1/opt/perl-$(1); fi
	./Configure -des -Dprefix=$$D1/opt/perl-$(1) -Dusethreads
	make
	make install
	rm -rf $$D1/opt/PERL-$(1)
endef

.ONESHELL:
compile-perl:
	$(call compile_perl,$$perl_v)

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

scala-install:
	echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
	curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
	apt update
	apt install sbt
