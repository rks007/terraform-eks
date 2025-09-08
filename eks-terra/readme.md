after creating the eks cluster through terraform

run this command then you can see your nodes running kubectl get nodes

aws eks update-kubeconfig --region <your-region> --name <cluster-name>