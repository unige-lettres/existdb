# eXist-db
* <https://exist-db.org>
* <http://exist-db.org:8098/exist/apps/doc/docker.xml>
* <https://rancher.unige.ch/dashboard/c/c-rpjpz/explorer>

* Build Docker image

`podman build --tag registry.gitlab.unige.ch/lettres/services/existdb .`

* Push Docker image to registry

`podman push registry.gitlab.unige.ch/lettres/services/existdb`

* Encrypt a password

`read -s PASSWORD && <<<"$PASSWORD" kubectl run kubeseal --quiet --image=docker.io/bitnami/sealed-secrets-kubeseal --rm --stdin --restart=Never --command -- kubeseal --raw --scope namespace-wide`

* Install an empty eXist-db instance

`helm install existdb-dev grammateus --values grammateus.yaml`
