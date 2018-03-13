oc new-project sogo
sudo oc login -u system:admin
sudo oc adm policy add-scc-to-user anyuid -z default -n sogo
oc new-app -f secret-template.yaml
oc-apply
oc start-build sogo --from-dir .
oc start-build sogo-httpd --from-dir .
