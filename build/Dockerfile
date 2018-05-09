FROM alpine:edge

RUN apk update && apk add python ansible unzip ca-certificates py-pip docker && apk upgrade

ADD https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip /tf.zip
ADD https://releases.hashicorp.com/terraform-provider-random/1.2.0/terraform-provider-random_1.2.0_linux_amd64.zip /tfr.zip
ADD https://releases.hashicorp.com/terraform-provider-aws/1.17.0/terraform-provider-aws_1.17.0_linux_amd64.zip /tfa.zip

RUN unzip /tf.zip -d /tf
RUN unzip /tfr.zip -d /tf/
RUN unzip /tfa.zip -d /tf/
RUN ln -s /tf/terraform /usr/local/bin/terraform

RUN pip install --upgrade pip boto3 botocore boto awscli docker-py

RUN mkdir /etc/ansible && echo 'localhost ansible_connection=local' > /etc/ansible/hosts

COPY provision.yml /
COPY tf.sh /

ENTRYPOINT [ "ansible-playbook", "provision.yml", "-e" ]

CMD [ "destroy=nothing" ]
