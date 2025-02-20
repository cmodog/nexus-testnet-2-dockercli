

## 使用方法如下

请自行安装好docker

```
docker pull silence365/nexus-testnet-2-dockercli:latest
docker run -d --name nexus-node-1 -e NODE_ID="node ID" silence365/nexus-testnet-2-dockercli:latest
```

## 单机多开

```
docker run -d --name nexus-node-1 -e PROVER_ID="your-prover-id-1" silence365/nexus-testnet-2-dockercli:latest
docker run -d --name nexus-node-2 -e PROVER_ID="your-prover-id-2" silence365/nexus-testnet-2-dockercli:latest
docker run -d --name nexus-node-3 -e PROVER_ID="your-prover-id-3" silence365/nexus-testnet-2-dockercli:latest
```
