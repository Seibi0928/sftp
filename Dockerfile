FROM atmoz/sftp:latest

COPY ./fixDirectoryOwnership.sh /etc/sftp.d/fixDirectoryOwnership.sh
RUN chmod +x /etc/sftp.d/fixDirectoryOwnership.sh
