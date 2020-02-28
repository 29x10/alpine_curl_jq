## Using curl to get vault secret using kubernetes auth

```
kubectl run -i -t --rm test-vault --image=binlei/alpine_curl_jq:latest --serviceaccount='vault' -- /bin/sh

JWT=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)

curl -s http://vault:8200/v1/auth/kubernetes/login -d "{\"role\": \"exampleapp\", \"jwt\": \"$JWT\"}" | jq

vault_token=$(curl -sk http://vault:8200/v1/auth/kubernetes/login -d "{\"role\": \"exampleapp\", \"jwt\": \"$JWT\"}" | jq .auth.client_token | sed 's/"//g')

curl -s -H "x-vault-token: $vault_token" http://vault:8200/v1/secret/data/exampleapp/config | jq
```

```
kubectl run -it --rm --image=mysql:8.0.19 --restart=Never mysql-client -- mysql -h mysql -ppassword

vault write database/config/mysql \
    plugin_name=mysql-database-plugin \
    connection_url="{{username}}:{{password}}@tcp(mysql:3306)/" \
    allowed_roles="mysql-role" \
    username="root" \
    password="password"


vault write database/roles/mysql-role \
    db_name=mysql \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';" \
    default_ttl="1h" \
    max_ttl="24h"

```
