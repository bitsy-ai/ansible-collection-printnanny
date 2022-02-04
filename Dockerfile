from quay.io/ansible/ubuntu2004-test-container:3.1.0

# pin jinja2>=2.11 to support nginx_core collection's use of boolean filter
# https://github.com/nginxinc/ansible-role-nginx-config/issues/195#issuecomment-1009679890
RUN pip3 install --user jinja2>=2.11