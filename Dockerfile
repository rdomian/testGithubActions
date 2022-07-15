FROM fedora:31

# Add rpm fusion repository, which is needed for ffmpeg
RUN dnf install -y \
        http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# NOTE: gcc, redhat-rpm-config,  python-devel, tkinter are needed for installation of matplotlib
RUN dnf install --setopt=deltarpm=false -y \
        gcc \
        redhat-rpm-config \
        vim \
        python3-tkinter \
        net-tools \
        mailx \
        python3-pip \
        python3-requests \
        ffmpeg \
        tesseract \
        python3-imaging \
        python3-pandas \
        python3-matplotlib \
        python3-gevent \
        python3-pillow \
        python3-devel && \
    rm -rf /var/cache/dnf/*

RUN pip install --upgrade pip
RUN pip  install \
        robotframework==4.1.3 \
        requests==2.27.1 \
        robotframework-requests==0.9.2 \
        robotframework-imaplibrary2==0.4.1 \
        robotframework-jsonschemalibrary \
        dnspython==2.2.0 \
        robotframework-faker==5.0.0 \
        pytesseract==0.3.8 \
        websocket-client==1.2.3 \
        robotframework-databaselibrary \
        pytz \
        future \
        get-video-properties \
        mysql-connector-python \
        robotframework-seleniumlibrary && \
        rm -rf ~/.pip/cache

# Install Google Chrome
RUN dnf install -y fedora-workstation-repositories \
                   'dnf-command(config-manager)'
RUN dnf config-manager --set-enabled google-chrome
RUN dnf install -y google-chrome-stable

# Install Chrome WebDriver
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
    ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

WORKDIR /usr/src/api-v3-test/app
# Set the locale
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 PYTHONIOENCODING=UTF-8
