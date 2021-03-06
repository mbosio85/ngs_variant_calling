FROM nfcore/base:1.7
LABEL authors="Mattia" \
      description="Docker image containing all requirements for nf-core/nftest pipeline"

COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
ENV PATH /opt/conda/envs/nf-core-nfcoretest-0.0.1/bin:$PATH
