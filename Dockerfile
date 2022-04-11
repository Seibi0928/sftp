FROM atmoz/sftp:latest

COPY ./fixDirectoryOwner.sh /etc/sftp.d/fixDirectoryOwner.sh
RUN chmod +x /etc/sftp.d/fixDirectoryOwner.sh
