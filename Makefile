.ONESHELL:
test:
	echo $(HOME)
	echo $$(which pip3)

.ONESHELL:
apt-install:
	sudo apt update
	sudo apt -y upgrade
	sudo apt -y dist-upgrade
	sudo apt -y remove xul-ext-ubufox gedit

	APTS="gnome-tweak-tool gnome-themes-standard htop kate kompare \
	chrome-gnome-shell opam openjdk-8-jre lm-sensors synaptic gparted gimp \
	inkscape nautilus-dropbox vlc apt-file autoconf libtool cmake net-tools \
	sshfs libopenmpi-dev npm libcanberra-gtk-module libcanberra-gtk3-module \
	android-tools-adb android-tools-fastboot libgirepository1.0-dev \
	virtualbox curl gir1.2-gtop-2.0 gir1.2-networkmanager-1.0 \
	gir1.2-clutter-1.0 rar libreoffice r-base rename pandoc aptitude \
	sra-toolkit libxm4 pdfshuffler ttf-mscorefonts-installer openssh-server \
	nfs-common nfs-kernel-server ghostscript libcurl4-openssl-dev \
	openjdk-11-jdk-headless"

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

export D1=/shared/D1

export PYTHON3_PACKAGES=numpy pandas nose python-libsbml \
	cobra escher seaborn pillow bokeh dnaplotlib pysb \
	biopython openpyxl xlrd fastcluster scikit-bio \
	scikit-learn rpy2 tzlocal

export PYTHON2_PACKAGES=qiime

export DEV_PACKAGES=testresources twine sphinx sphinx-autobuild \
	sphinx_rtd_theme versioneer pylint autopep8

export CUDA_PYTHON3_PACKAGES=pycuda pygpu scikit-cuda \
	torchvision tensorflow-gpu theano cntk-gpu

export JUPYTER_PACKAGES=jupyter jupyterlab ipykernel nbopen rise

export PERL_PACKAGES=JSON Math::CDF HTML::Template XML::Compile::SOAP11 \
	XML::Compile::WSDL11 XML::Compile::Transport::SOAPHTTP

system-perl-packages-install:
	sudo cpan $$PERL_PACKAGES

local-python-packages-install:
	$$D1/bin/pip3 install $$PYTHON3_PACKAGES --upgrade

system-python-packages-install:
	sudo -H pip3 install $$PYTHON3_PACKAGES --upgrade
	sudo -H pip2 install $$PYTHON2_PACKAGES --upgrade

cuda-and-python-packages-install:
	cd $$D1/opt/ubuntu-software

	sudo apt -y install linux-headers-$(uname -r)
	sudo dpkg -i cuda-repo-ubuntu1804-10-0-local-10.0.130-410.48_1.0-1_amd64.deb
	sudo apt-key add /var/cuda-repo-10-0-local-10.0.130-410.48/7fa2af80.pub
	sudo apt update
	sudo apt -y install cuda
	CUDA_APTS="cuda-toolkit-10-0 cuda-tools-10-0 cuda-runtime-10-0 \
	cuda-compiler-10-0 cuda-libraries-10-0 cuda-libraries-dev-10-0 cuda-drivers \
	nvidia-cuda-toolkit"
	for apt in $$CUDA_APTS; do sudo apt -y install $$apt; done

	sudo -H pip3 install http://download.pytorch.org/whl/cu100/torch-1.0.0-cp36-cp36m-linux_x86_64.whl
	sudo -H pip3 install $$CUDA_PYTHON3_PACKAGES --upgrade

devtools-python-packages-install:
	sudo -H pip3 install $$DEV_PACKAGES --upgrade
	sudo -H pip2 install $$DEV_PACKAGES --upgrade

jupyter-install:
	sudo -H pip3 install $$JUPYTER_PACKAGES --upgrade

	# install python3 kernel
	python3 -m ipykernel install --user
	python3 -m nbopen.install_xdg

	# install and enable rise
	sudo jupyter-nbextension install rise --py --sys-prefix
	sudo jupyter-nbextension enable rise --py --sys-prefix

# 	# install and enable contrib_nbextensions
# 	sudo jupyter-nbextension install jupyter_contrib_nbextensions --py --sys-prefix
# 	sudo jupyter-nbextension enable jupyter_contrib_nbextensions --py --sys-prefix
#
# 	# install and enable nbextensions_configurator
# 	sudo jupyter-nbextension install jupyter_nbextensions_configurator --py --sys-prefix
# 	sudo jupyter-nbextension enable jupyter_nbextensions_configurator --py --sys-prefix
#
# 	# install and enable ipyparallel
# 	sudo jupyter-nbextension install --sys-prefix --py ipyparallel
# 	sudo jupyter-nbextension enable --sys-prefix --py ipyparallel
# 	sudo jupyter-serverextension enable --sys-prefix --py ipyparallel

kernels-jupyter:
	$$D1/bin/R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
	library(devtools); \
	devtools::install('/opt/github-repositories/IRkernel.IRkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'cran')"

	sudo R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
	library(devtools); \
	devtools::install('/opt/github-repositories/IRkernel.IRkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'ir')"

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

local-r-packages-install:
	$$D1/bin/R -e "install.packages('tidyverse', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/'); \
			install.packages('knitr', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/'); \
			install.packages('rmarkdown', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/'); \
			install.packages('gridExtra', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/'); \
			install.packages('plotly', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/'); \
			install.packages('Cairo', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/'); \
			install.packages('ggpubr', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/'); \
			install.packages('ape', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/'); \
			install.packages('biom', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/'); \
			install.packages('optparse', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/'); \
			install.packages('RColorBrewer', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/'); \
			install.packages('randomForest', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/'); \
			install.packages('vegan', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/');"

	# install bioConductor packages
	$$D1/bin/R -e "source('https://bioconductor.org/biocLite.R'); \
	biocLite(); \
	biocLite('dada2'); \
	biocLite('edgeR'); \
	biocLite('phyloseq'); \
	biocLite('DESeq'); \
	biocLite('DESeq2'); \
	biocLite('microbiome'); \
	biocLite('metagenomeSeq')"

.ONESHELL:
slurm-install:
	sudo rm -rf /var/lib/slurm-llnl /var/run/slurm-llnl /var/log/slurm-llnl
	sudo apt-get -y remove --purge slurm-wlm slurmdbd
	sudo apt-get -y autoremove
	sudo apt-get -y install slurm-wlm slurmdbd

	sudo mkdir -p /var/spool/slurmd
	sudo mkdir -p /var/lib/slurm-llnl
	sudo mkdir -p /var/lib/slurm-llnl/slurmd
	sudo mkdir -p /var/lib/slurm-llnl/slurmctld
	sudo mkdir -p /var/run/slurm-llnl
	sudo mkdir -p /var/log/slurm-llnl

	sudo touch /var/log/slurm-llnl/slurmd.log
	sudo touch /var/log/slurm-llnl/slurmctld.log

	sudo chmod -R 755 /var/spool/slurmd
	sudo chmod -R 755 /var/lib/slurm-llnl/
	sudo chmod -R 755 /var/run/slurm-llnl/
	sudo chmod -R 755 /var/log/slurm-llnl/

	sudo chown -R slurm:slurm /var/spool/slurmd
	sudo chown -R slurm:slurm /var/lib/slurm-llnl/
	sudo chown -R slurm:slurm /var/run/slurm-llnl/
	sudo chown -R slurm:slurm /var/log/slurm-llnl/

.ONESHELL:
slurm-conf:
	sudo rm /var/log/slurm-llnl/slurmd.log
	sudo rm /var/log/slurm-llnl/slurmctld.log
	sudo cp slurm.conf gres.conf /etc/slurm-llnl/

	dd if=/dev/urandom bs=1 count=1024 > munge.key
	sudo cp munge.key /etc/munge/munge.key
	sudo chown munge:munge /etc/munge/munge.key
	sudo chmod 400 /etc/munge/munge.key
	sudo chmod 711 /var/lib/munge/
	sudo chmod 755 /var/run/munge/

	sudo systemctl restart slurmd
	sudo systemctl restart slurmctld

	sudo service slurmd status
	sudo service slurmctld status

.ONESHELL:
install-others:
	cd $$D1/opt/ubuntu-software/

	sh Anaconda3-5.3.0-Linux-x86_64.sh
	sh cplex_studio128.linux-x86-64.bin
	sh Cytoscape_3_7_0_unix.sh

	PTOOLS="pathway-tools-21.5-linux-64-tier1-install"
	chmod u+x $(PTOOLS); ./$(PTOOLS); chmod u-x $(PTOOLS)

	tar xvzf COPASI-4.24.197-Linux-64bit.tar.gz -C $$D1/opt
	tar xvzf gurobi8.0.1_linux64.tar.gz -C $$D1/opt
