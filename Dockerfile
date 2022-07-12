FROM cr.imroc.cc/library/grpc-tools:latest
COPY server /server
CMD ["/server"]