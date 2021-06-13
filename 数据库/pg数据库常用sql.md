## 1.删除schema以及里面数据

```sql
drop SCHEMA "7b4cf94f1be840318754e9b9f97e3987" CASCADE;
```

## 2.快速创建序列自增

使用serial8类型

```sql
CREATE TABLE "developer_gs"."gscheduler_project_purview"
(
    "id"            serial8,
    "project_id"    int4,
    "user_group_id" varchar(255),
    "role_id"       varchar(255),
    "project_name"  varchar(255)
)
;
```

## 3.sql查询去掉重复数据

使用distinct字段

```sql
SELECT distinct role_code FROM "auth_role" where tenant_code is not null and tenant_code <> 'default'
```

## 4.pg全库备份&恢复

```sql
#进入pg部署的机器
sudo su;
su postgres;
cd ~;
pg_dump kipf>kipf_v2.7.1_poc.sql;
su yijialuo@gridsum.com;
cd ~;
sudo mv /var/lib/pgsql/kipf_v2.7.1_poc.sql ./;
# 恢复
```

