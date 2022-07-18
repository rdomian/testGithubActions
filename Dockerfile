FROM python:2.7-slim

# Update the repositories
# Install packages
RUN apt update && apt install -y curl gnupg2 locales locales-all unzip jq bzip2 libdbus-glib-1-2

# Install Chrome WebDriver
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
    ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

# Install Google Chrome
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get -yqq update && \
    apt-get -yqq install google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

# Install Geckodriver
RUN GECKODRIVER_LATEST_VERSION=`curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest | jq -r '.tag_name'` && wget https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_LATEST_VERSION/geckodriver-$GECKODRIVER_LATEST_VERSION-linux64.tar.gz && tar xvzf geckodriver* && chmod +x geckodriver && mv geckodriver /usr/local/bin && rm -rf geckodriver*

#Install Firefox
RUN wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64" && tar xjf FirefoxSetup.tar.bz2 -C /opt/ && rm -rf FirefoxSetup.tar.bz2 && ln -s /opt/firefox/firefox /usr/local/bin/firefox

WORKDIR /usr/src
COPY requirements.txt .
RUN pip install -r requirements.txt
ENV LANG=en_US.UTF-8  LANGUAGE=en_US:en  LC_ALL=en_US.UTF-8 PYTHONIOENCODING=UTF-8

COPY . .