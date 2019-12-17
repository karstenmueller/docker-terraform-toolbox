# docker-terraform-toolbox

Docker container providing Terraform, Inspec, kubectl, helm and cloud provider tools (az, aws, gcloud)

## Create the image

~~~zsh
cd docker
make
make test
make release
~~~

## Use the container via shell functions

~~~zsh
eval $(bash dockerize.sh)
~~~
