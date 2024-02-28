# Use a base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Update and install required packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    git \
    libssl-dev \
    libnl-3-dev \
    libnl-genl-3-dev \
    pkg-config \
    libpcap-dev \
    wireless-tools \
    && rm -rf /var/lib/apt/lists/*

# Clone and build mdk4
RUN git clone https://github.com/aircrack-ng/mdk4.git && \
    cd mdk4 && \
    make && \
    make install && \
    cd ..

# Clone and build AWUS036ACH drivers
RUN git clone https://github.com/aircrack-ng/rtl8812au.git && \
    cd rtl8812au && \
    make && \
    make install && \
    cd ..

# Cleanup unnecessary files
RUN rm -rf mdk4 rtl8812au

# Run the WiFi scan using mdk4
CMD ["mdk4", "wlan0", "m"] # Change wlan0 to your wireless interface if it differs
