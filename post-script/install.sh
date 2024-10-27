# helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
# helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace --version '4.5.2' --values ./ingress/values.yaml

helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd -n argocd --create-namespace --version '6.7.2' --values ./argocd/values.yaml