# K8s

整理 Kubernetes 相關技術的專案

# Before 2024

Kubernetes is an open-source system for automating deployment, scaling and management of containerized applications.

I study to build kubernetes 1.6.x by typing commands one by one, and I wish to build kubernetes by automatic script files.

The goal is to simplify the building process.

All of documents about how to build my kubernetes 1.6.x are listed in 'k8s-v1.6.8 maunal install' folder.

After build kubernetes 1.6.x, I feel its architecture is not perfect.

Sometime we need to restart nodes many times and waited for the communications among nodes.

Therefore I had started built kubernetes 1.8.x and written documents of another folder 'k8s-v1.8.x manual install'.

The second folder is better than first folder.

The new version of kubernetes have more flexible architecture, because it's a fully Docker container architecture.

I thanks for all of authors of the reference paper helps me to finish these documents.

Finally, the detail configuration listed in k8s-config.json file.

The execution of scripts needs 'jq' package, which is a lightweight and flexible command-line JSON processor.

