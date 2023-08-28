ARG PROJ_VERSION=9.1.1
ARG RUBY_VERSION=3.2.0

FROM ruby:${RUBY_VERSION}

ARG PROJ_VERSION
ARG RUBY_VERSION

ENV RUBY_VERSION=${RUBY_VERSION}
ENV PROJ_VERSION=${PROJ_VERSION}

RUN apt-get update -y && apt-get install -y --fix-missing --no-install-recommends \
    software-properties-common \
    build-essential \
    ca-certificates \
    cmake \
    wget \
    unzip \
    zlib1g-dev \
    libsqlite3-dev \
    sqlite3 \
    libcurl4-gnutls-dev \
    libtiff5-dev \
    nodejs \
    postgresql-client \
    libgeos-dev \
    libblas-dev \
    liblapack-dev \
    libf2c2-dev \
    wkhtmltopdf \
    curl

RUN git clone --depth 1 --branch ${PROJ_VERSION} https://github.com/OSGeo/PROJ.git

RUN cd PROJ \ 
	&& mkdir build \
	&& cd build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF \
	&& make -j$(nproc) \
	&& make install

RUN echo "deb https://apt.fullstaqruby.org debian-12 main" > /etc/apt/sources.list.d/fullstaq-ruby.list \
    && curl -SLfo /etc/apt/trusted.gpg.d/fullstaq-ruby.asc https://raw.githubusercontent.com/fullstaq-labs/fullstaq-ruby-server-edition/main/fullstaq-ruby.asc \
    && apt-get update -y && apt-get install -y --no-install-recommends \
    fullstaq-ruby-common \
    fullstaq-ruby-${RUBY_VERSION}\
    && rm -rf /var/lib/apt/lists/*