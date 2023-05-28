FROM anasty17/mltb:latest

LABEL maintainer="vijaymalav564 <vijaymalav564@gmail.com>"

ENV TZ Asia/Kolkata

# apt update
RUN apt update

# Install sudo
RUN apt install apt-utils sudo -y

RUN \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata \
&& ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
&& apt-get install -y tzdata \
&& dpkg-reconfigure --frontend noninteractive tzdata

ENV LANG=C.UTF-8
ENV JAVA_OPTS=" -Xmx7G "
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=~/bin:/usr/local/bin:/home/root/bin:$PATH


RUN \
apt-get update && apt install git ssh tmate -y && git clone https://github.com/akhilnarang/scripts.git /tmp/scripts \
&& sudo bash /tmp/scripts/setup/android_build_env.sh \
&& rm -rf /tmp/scripts

# install some extra packages
RUN \
sudo apt install --no-install-recommends -y \
            neofetch vim ruby \
            bc \
            binutils-dev \
            bison \
            build-essential \
            ca-certificates \
            ccache \
            clang \
            cmake \
            curl \
            file \
            flex \
            git \
            libelf-dev \
            libssl-dev \
            lld \
            make \
            ninja-build \
            python3-dev \
            texinfo \
            u-boot-tools \
            xz-utils \
            zlib1g-dev 

RUN \
sudo gem install rmega

# Install all required packages
RUN apt-get update -q -y \
  && apt-get install -q -y --no-install-recommends \
    # Core Apt Packages
    apt-utils apt-transport-https python3-apt \
    # Linux Standard Base Packages
    sudo git ffmpeg maven nodejs ca-certificates-java pigz tar rsync rclone aria2 adb autoconf automake axel bc bison build-essential ccache lsb-core lsb-security ca-certificates systemd udev \
    # Upload/Download/Copy/FTP utils
    git curl wget wput axel rsync mediainfo \
    # GNU and other core tools/utils
    binutils coreutils bsdmainutils util-linux patchutils libc6-dev sudo \
    # Security CLI tools
    ssh openssl libssl-dev sshpass gnupg2 gpg \
    # Tools for interacting with an Android platform
    android-sdk-platform-tools adb fastboot squashfs-tools \
    # OpenJDK8 as Java Runtime
    openjdk-8-jdk ca-certificates-java \
    maven nodejs \
    # Python packages
    python-all-dev python3-dev python3-requests python3-pip \
    # Compression tools/utils/libraries
    zip unzip lzip lzop zlib1g-dev xzdec xz-utils pixz p7zip-full p7zip-rar zstd libzstd-dev lib32z1-dev \
    # GNU C/C++ compilers and Build Systems
    build-essential gcc gcc-multilib g++ g++-multilib \
    # make system and stuff
    clang llvm lld cmake automake autoconf \
    # XML libraries and stuff
    libxml2 libxml2-utils xsltproc expat re2c \
    # Misc utils
    file gawk xterm screen rename tree schedtool software-properties-common \
    dos2unix jq flex bison gperf ibb2-dev pngcrush imagemagick optipng advancecomp \
    # LTS specific Unique packages
    ${UNIQ_PACKAGES} \
    # Additional
    kmod \
  && unset UNIQ_PACKAGES

# Use python2 as the Default python (required for custom recovery building)
RUN \
sudo ln -sf /usr/bin/python2 /usr/bin/python

# Run bash
CMD ["bash"]
