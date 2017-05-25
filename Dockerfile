FROM ubuntu
RUN apt-get update

RUN apt-get install perl -y
RUN apt-get install gcc -y 
RUN apt-get install bioperl -y
RUN apt-get install libpar-packer-perl -y
RUN apt-get install wget -y


RUN mkdir /tool
ENV HOME=/tool
RUN chmod -R 777 /tool

WORKDIR /tool

RUN wget http://membres-timc.imag.fr/Olivier.Francois/snmf/files/sNMF_CL_v1.2.zip 
RUN unzip sNMF_CL_v1.2.zip
RUN rm sNMF_CL_v1.2.zip
RUN mv sNMF_CL_v1.2/ ./
RUN rm -rf examples/
RUN rm -rf documentation/
RUN rm README

ADD ./* $HOME/
RUN chmod +x $HOME/snmf.sh
RUN chmod +x plink
RUN chmod +x install.command
RUN ./install.command

RUN pp -o snmf Snmf.pl

RUN apt-get purge gcc -y
RUN apt-get purge bioperl -y
RUN apt-get purge libpar-packer-perl -y
RUN apt-get purge perl -y
RUN rm -f /usr/local/bin/wget
