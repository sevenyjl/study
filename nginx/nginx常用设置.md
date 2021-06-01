1.nginx反向代理header丢失问题

```conf
http {
	...
    # 开启支持header下划线
    underscores_in_headers on;
    server {
    ...
    }
}
```

2.nginx反向代理下划线问题