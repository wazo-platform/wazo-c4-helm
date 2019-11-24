VERSION=$$(grep version: wazo-c4/Chart.yaml | sed -e 's/.*: *//g')

.PHONY: template
template:
	helm template wazo-c4/ --namespace="wazo" > wazo-c4-$(VERSION).yaml

.PHONY: clean
clean:
	rm -fr wazo-c4-$(VERSION)*.tgz wazo-c4-$(VERSION)*.yaml tmp.*

.PHONY: package
package:
	helm package wazo-c4

.PHONY: upload
upload:
	curl --data-binary "@wazo-c4-$(VERSION).tgz" http://charts.k8s.wazo.community/api/charts

.PHONY: apply
apply:
	kubectl apply -f wazo-c4-$(VERSION).yaml

.PHONY: lint
lint:
	helm lint wazo-c4
	yamllint -c .yamllint ./*.yaml
