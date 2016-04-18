MToolBox dockerized w/o heavy files
===================
This is a dockerized lite MToolBox, for human mitochondrial DNA analysis. Lite version requires you to mount genomes and indices from elsewhere. Image mtoolbox contains these files.

Install
-------
~~~
mkdir -p /usr/local/share/genomes/ && cd /usr/local/share/genomes/ \
        && wget -nv https://sourceforge.net/projects/mtoolbox/files/genome_fasta/chrRCRS.fa.tar.gz -O - | tar xz \
        && wget -nv https://sourceforge.net/projects/mtoolbox/files/genome_fasta/chrRCRS.fa.fai \
        && wget -nv https://sourceforge.net/projects/mtoolbox/files/genome_fasta/hg19RCRS.fa.tar.gz -O - | tar xz \
        && wget -nv https://sourceforge.net/projects/mtoolbox/files/genome_fasta/hg19RCRS.fa.fai

mkdir -p /usr/local/share/gmapdb/ && cd /usr/local/share/gmapdb/ \
        && wget -nv http://sourceforge.net/projects/mtoolbox/files/genome_index/chrRCRS.tar.gz -O - | tar xz
~~~


Usage
-----
Example:
~~~
$ docker run --rm -v /usr/local/share/genomes:/usr/local/share/genomes -v /usr/local/share/gmapdb/usr/local/share/gmapdb:/usr/local/share/gmapdb -v /tmp/d/mito.bam:/workdir/mito.bam -v /tmp/d/mito.bai:/workdir/mito.bai -v /tmp/eeee:/tmp/output -i -t mtoolbox-lite MToolBox.sh -i bam -r RCRS -o /tmp/output -M  -I
~~~

Output will be written to /tmp/eeee in the example above.

Known issues
---------------
mtoolbox is crappy software, inputed .bam and .bai files cannot have dot (.) in filename, so use Sample_XXX.bam instead of f.ex. Sample_
XXX.mito.bam

Concact
-------
Piotr Stawiński stawinski@g.pl
