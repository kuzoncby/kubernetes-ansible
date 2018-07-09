# 使用 Ansible 安装 Kubernetes

编辑[production.ini](./production.ini)和[all.yaml](./group_vars/all.yaml)文件。

## 测试连接状态

```bash
make test
```

## 安装

```bash
make install
```

## 检测

## 访问 web console

为 traefik.cluster.local 创建一条 CNAME 记录并指向：storage-2.cluster.local

访问 http://traefik.cluster.local/dashboard/