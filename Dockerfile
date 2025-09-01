FROM amazoncorretto:17-alpine

# Install curl for health checks
RUN apk add --no-cache curl

# Create canton user and directories
RUN adduser -D canton
RUN mkdir -p /canton/bin /canton/lib /canton/config /canton/daml
RUN chown -R canton:canton /canton

# Download Canton
USER canton
WORKDIR /canton

# Download Canton Open Source Edition
RUN curl -L https://github.com/digital-asset/daml/releases/download/v2.10.2/canton-open-source-2.10.2.tar.gz | tar -xz --strip-components=1

# Make sure the canton binary is executable
RUN chmod +x /canton/bin/canton

# Expose ports
EXPOSE 5011 5012 5021 5022 5031 5032 7575

# Set the default command
CMD ["/canton/bin/canton", "daemon", "--config", "/canton/config/canton.conf"]