# Copyright: Piotr Stawinski 2015
# build: docker build -t mtoolbox-lite .
# run me: docker run --rm -v /tmp/d/mito.bam:/workdir/mito.bam -v /tmp/d/mito.bai:/workdir/mito.bai -v /tmp/eeee:/tmp/output -i -t mtoolbox-lite MToolBox.sh -i bam -r RCRS -o /tmp/output -M  -I
# or docker run --rm -i -t mtoolbox-lite /bin/bash for tests
# BEWARE: mtoolbox is crappy software, inputed .bam and .bai files cannot have dot (.) in filename, so use Sample_XXX.bam instead of f.ex. Sample_XXX.mito.bam

FROM python:2.7
MAINTAINER Piotr Stawinski stawinski@g.pl
# TODO join these lines below later
RUN apt-get update && apt-get install -y \
	make	\
	automake \
	gcc \
	build-essential \
	g++ \
	cpp \
	libc6-dev \
	man-db \
	autoconf \
	pkg-config \
	wget \
	zlib1g-dev \
	ncurses-dev \
	default-jdk

# install samtools
RUN cd && wget -nv -O - 'https://github.com/samtools/samtools/releases/download/1.2/samtools-1.2.tar.bz2' | tar -xj \
	&& cd samtools-1.2 && make prefix=/usr/local/bin/samtools && make install

# install gmap
RUN  cd && wget -nv -O - 'https://github.com/julian-gehring/GMAP-GSNAP/archive/2012-06-02.tar.gz' | tar -xz \
	&& cd GMAP-GSNAP-2012-06-02 && ./configure --prefix /usr/local && make && make install

# install muscle
RUN cd && wget -nv -O - http://www.drive5.com/muscle/downloads3.8.31/muscle3.8.31_i86linux64.tar.gz | tar -xz \
	&& mv muscle3.8.31_i86linux64 /usr/local/bin/muscle

# download mtoolbox
RUN cd && wget -nv -O - 'http://downloads.sourceforge.net/project/mtoolbox/MToolBox.v0.3.3.tar.gz' -O - | tar -xz

# download genomes
#RUN mkdir -p /usr/local/share/genomes/ && cd /usr/local/share/genomes/ \ 
#	&& wget -nv https://sourceforge.net/projects/mtoolbox/files/genome_fasta/chrRCRS.fa.tar.gz -O - | tar xz \
#	&& wget -nv https://sourceforge.net/projects/mtoolbox/files/genome_fasta/chrRCRS.fa.fai \
#	&& wget -nv https://sourceforge.net/projects/mtoolbox/files/genome_fasta/hg19RCRS.fa.tar.gz -O - | tar xz \
#	&& wget -nv https://sourceforge.net/projects/mtoolbox/files/genome_fasta/hg19RCRS.fa.fai

# download mtoolbox gmap indices
#RUN mkdir -p /usr/local/share/gmapdb/ && cd /usr/local/share/gmapdb/ \
#	&& wget -nv http://sourceforge.net/projects/mtoolbox/files/genome_index/chrRCRS.tar.gz -O - | tar xz 

ENV PATH /root/MToolBox:$PATH

WORKDIR /workdir

CMD ["/bin/bash"]
