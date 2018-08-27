# zookeeper / kafka for kubernetes

* StatefulSet with nodeAffinity
```yaml
 affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - zookeeper
            topologyKey: "kubernetes.io/hostname"
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: kubernetes.io/hostname
                operator: In
                values:
                - node-0
                - node-1
                - node-2
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            preference:
              matchExpressions:
              - key: kubernetes.io/hostname
                operator: In
                values:
                - node-0
          - weight: 50
            preference:
              matchExpressions:
              - key: kubernetes.io/hostname
                operator: In
                values:
                - node-1
          - weight: 1
            preference:
              matchExpressions:
              - key: kubernetes.io/hostname
                operator: In
                values:
                - node-2
 ```
* Outside -out of cluster- access
```yaml
  ports:
        - name: inside
          containerPort: 9092
          hostPort: 9192
        - name: outside
          containerPort: 9094
          hostPort: 9194
```
```yaml
 - name: MY_NODE_NAME
          valueFrom:
            fieldRef:
              fieldPath: spec.nodeName
```
```
sed -i 's/:9194/'${MY_NODE_NAME}'.siege.red:9194/g' /opt/kafka/config/server.properties
```
> server.properties exmaple on node-0
```
broker.id=1
listeners=PLAINTEXT://:9092,OUTSIDE://:9094
advertised.listeners=OUTSIDE://node-0.outside.out:9194,PLAINTEXT://:9092
zookeeper.connect=zoo:2181
zookeeper.connection.timeout.ms=6000
listener.security.protocol.map=PLAINTEXT:PLAINTEXT,OUTSIDE:PLAINTEXT
inter.broker.listener.name=PLAINTEXT
auto.create.topics.enable=false
```
