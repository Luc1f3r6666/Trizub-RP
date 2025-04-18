FROM open-samp/samp

COPY . /samp
WORKDIR /samp

CMD ["./samp03svr"]