FROM ubuntu:latest

# Update and install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y fortune-mod cowsay curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory and copy script
WORKDIR /app
COPY wisecow.sh /app/

# Expose port
EXPOSE 4499

# Set command to run the script
CMD ["./wisecow.sh"]