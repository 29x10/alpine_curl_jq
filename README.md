## Using curl to get vault secret using kubernetes auth

```
kubectl run -i -t --rm test-vault --image=binlei/alpine_curl_jq:latest --serviceaccount='vault' -- /bin/sh

JWT=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)

curl -s http://vault:8200/v1/auth/kubernetes/login -d "{\"role\": \"exampleapp\", \"jwt\": \"$JWT\"}" | jq

vault_token=$(curl -sk http://vault:8200/v1/auth/kubernetes/login -d "{\"role\": \"exampleapp\", \"jwt\": \"$JWT\"}" | jq .auth.client_token | sed 's/"//g')

curl -s -H "x-vault-token: $vault_token" http://vault:8200/v1/secret/data/exampleapp/config | jq
```


