oc new-project sogo || oc project sogo
sudo oc login -u system:admin
sudo oc adm policy add-scc-to-user anyuid -z default -n sogo
oc new-app -f secret-template.yaml
oc-apply
sleep 5
oc start-build sogo --from-dir .
sleep 120
oc start-build sogo-httpd --from-dir .
