oc new-project sogo
sudo oc login -u system:admin
sudo oc adm policy add-scc-to-user anyuid -z default -n sogo
oc new-app -f secret-template.yaml
oc-apply
