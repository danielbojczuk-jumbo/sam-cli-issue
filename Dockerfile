FROM public.ecr.aws/sam/build-python3.12

RUN dnf install -y dnf-plugins-core
RUN dnf config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
RUN dnf -y install terraform