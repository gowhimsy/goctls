Name: {{.serviceName}}.api
Host: {{.host}}
Port: {{.port}}
Timeout: 2000

Auth:
  AccessSecret: # the same as core
  AccessExpire: 259200

CROSConf:
  Address: '*'

Log:
  ServiceName: {{.serviceName}}ApiLogger
  Mode: file
  Path: /home/data/logs/{{.serviceName}}/api
  Level: info
  Compress: false
  KeepDays: 7
  StackCoolDownMillis: 100

Prometheus:
  Host: 0.0.0.0
  Port: 4000
  Path: /metrics

{{if .useEnt}}DatabaseConf:
  Type: mysql
  Host: 127.0.0.1
  Port: 3306
  DBName: simple_admin
  Username: # set your username
  Password: # set your password
  MaxOpenConn: 100
  SSLMode: disable
  CacheTime: 5
{{end}}
{{if .useCasbin}}RedisConf:
  Host: 127.0.0.1:6379
  Type: node

CasbinDatabaseConf:
  Type: mysql
  Host: 127.0.0.1
  Port: 3306
  DBName: simple_admin
  Username: # set your username
  Password: # set your password
  MaxOpenConn: 100
  SSLMode: disable
  CacheTime: 5

CasbinConf:
  ModelText: |
    [request_definition]
    r = sub, obj, act
    [policy_definition]
    p = sub, obj, act
    [role_definition]
    g = _, _
    [policy_effect]
    e = some(where (p.eft == allow))
    [matchers]
    m = r.sub == p.sub && keyMatch2(r.obj,p.obj) && r.act == p.act
{{end}}