1.Feign单元测试

![image-20210528105822968](fegin图片/image-20210528105822968.png)

```java
package com.gs.cd.kmp.api;


import com.gs.cd.kmp.api.entity.Tenant;
import lombok.extern.slf4j.Slf4j;
import net.bytebuddy.asm.Advice;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.ImportAutoConfiguration;
import org.springframework.boot.autoconfigure.http.HttpMessageConvertersAutoConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.cloud.netflix.ribbon.RibbonAutoConfiguration;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.cloud.openfeign.FeignAutoConfiguration;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.cloud.openfeign.ribbon.FeignRibbonClientAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @Author seven
 * @Date 2021/5/28 10:33
 * @Description
 * @Version 1.0
 */

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = AuthClientTest.class)
@Import({FeignAutoConfiguration.class, HttpMessageConvertersAutoConfiguration.class})
@EnableFeignClients(clients = AuthClientTest.AuthTestClient.class)
@ComponentScan(value = "com.gs.cd.kmp.api")
public class AuthClientTest {

    /**
     * 继承需要调用的 client
     */
    @FeignClient(value = "auth-center-test", url = "http://10.202.40.72:30325/")
    public interface AuthTestClient extends AuthClient {
    }

    @Autowired
    private AuthTestClient authTestClient;

    @Test
    public void listByRoleCode() {
    }

    @Test
    public void listByRoleIds() {
    }

    @Test
    public void listLoginUserAllResource() {
    }

    @Test
    public void tenantListAllSimple() {
    }

    @Test
    public void listAllValidTenantCode() {
    }

    @Test
    public void putCreate() {
    }

    @Test
    public void enableTenant() {
        //必要参数如下
        Tenant tenant = new Tenant();
        tenant.setCode("default_feign");
        tenant.setId("default_feign");
        tenant.setDescription("系统默认创建");
        tenant.setAdminLoginName("admin");
        tenant.setAdminName("admin");
        tenant.setName("default_feign");
        authTestClient.putCreate(tenant);
    }
}
```

