# Copyright(c) Red Hat Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.PHONY: all 
all: docker kind-setup image-load run-server-pod run-client-pod 

help: ## Display this help.
        @awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

docker: ## Build docker image
	docker build -t ans -f Dockerfile .

image-load: ## Load the image to the kind cluster
	kind load --name ans-deployment docker-image ans

kind-setup: ## Setup a kind cluster called ans-deployment
	kind create cluster --config kind-config.yaml --name ans-deployment 

kind-del: ## Remove a kind cluster called ans-deployment
	kind delete cluster --name ans-deployment

run-server-pod: ## Run the server pod
	kubectl create -f server-pod.yaml

run-client-pod: ## Run the client pod
	kubectl create -f client-pod.yaml

server-logs: ## Get the server pod logs (Empty is good).
	kubectl logs server-pod

client-logs: ## Get the client pod logs. (Should show connection refused).
	kubectl logs client-pod
