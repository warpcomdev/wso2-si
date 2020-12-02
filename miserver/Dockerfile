FROM wso2/wso2mi:1.3.0-SNAPSHOT

# Volumes for running as non-root. Move out of the way everything
# that WSO2 might want to write to.
VOLUME "/opt/wso2mi"

# We need to have all files readable by anyone, to copy them.
USER root
RUN chmod -R a+rX /home/wso2carbon
USER wso2carbon
