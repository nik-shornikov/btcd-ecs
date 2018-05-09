FROM golang:latest

ADD https://raw.githubusercontent.com/btcsuite/btcd/master/release/GIT-GPG-KEY-conformal.txt /key.txt
RUN gpg --import /key.txt
RUN go get -u github.com/btcsuite/btcd/...
WORKDIR ${GOPATH}/src/github.com/btcsuite/btcd
RUN git tag -v BTCD_0_12_0_BETA

COPY btcd.conf /root/.btcd/btcd.conf

ENTRYPOINT ["btcd"]
