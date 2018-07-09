# Install Kubernetes by Ansible

Edit [production.ini](./production.ini) and [all.yaml](./group_vars/all.yaml)

## Test connection

```bash
make test
```

## Install

```bash
make install
```

## Reset

```bash
make reset
```

## Access web console

Create a CNAME as traefik.cluster.local and point to storage-2.cluster.local

Access http://traefik.cluster.local/dashboard/

## License

MIT