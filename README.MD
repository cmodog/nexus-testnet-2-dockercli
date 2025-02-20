

## 使用方法如下

请自行安装好docker

```
git clone https://github.com/cmodog/nexus-testnet-2-dockercli.git
cd nexus-testnet-2-dockercli
docker build -t nexus-cli-node .
docker run -d --name nexus-node-1 -e NODE_ID="node ID" nexus-cli-node
```

## 单机多开

```
docker run -d --name nexus-node-1 -e PROVER_ID="your-prover-id-1" nexus-cli-node
docker run -d --name nexus-node-2 -e PROVER_ID="your-prover-id-2" nexus-cli-node
docker run -d --name nexus-node-3 -e PROVER_ID="your-prover-id-3" nexus-cli-node
```
