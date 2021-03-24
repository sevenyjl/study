# Springboot自定义监控指标

> 在[上文](https://gitee.com/GTeam_seven/study/blob/master/promethues%E7%9B%91%E6%8E%A7/04%E6%99%8B%E7%BA%A7-%E4%B8%8Espringboot%E7%9A%84%E4%BD%BF%E7%94%A8.md)基础上进行

1.构建prometheus指标

```java

import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.DistributionSummary;
import io.micrometer.core.instrument.MeterRegistry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * 此次模拟监控：订单发起次数、金额统计指标
 */
@Component
public class PrometheusCustomMonitor {
    /**
     * 订单发起次数
     */
    private Counter orderCount;
    /**
     * 金额统计
     */
    private DistributionSummary amountSum;

    private final MeterRegistry registry;

    @Autowired
    public PrometheusCustomMonitor(MeterRegistry registry) {
        this.registry = registry;
    }

    @PostConstruct
    private void init() {
        orderCount = registry.counter("order_request_count", "order", "test-svc");
        amountSum = registry.summary("order_amount_sum", "orderAmount", "test-svc");
    }

    public Counter getOrderCount() {
        return orderCount;
    }

    public DistributionSummary getAmountSum() {
        return amountSum;
    }
}
```

2.Controller进行指标记录

```java

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Random;

@RestController
public class TestController {

    @Resource
    private PrometheusCustomMonitor monitor;

    @RequestMapping("/order")
    public String order() throws Exception {
        // 统计下单次数
        monitor.getOrderCount().increment();
        Random random = new Random();
        int amount = random.nextInt(100);
        // 统计金额
        monitor.getAmountSum().record(amount);
        return "下单成功, 金额: " + amount;
    }
}
```

3.请求查看

![image-20210324143114253](05晋级-springboot的自定义监控指标图片/image-20210324143114253.png)![image-20210324143133211](05晋级-springboot的自定义监控指标图片/image-20210324143133211.png)

4.使用promsq进行查看

![image-20210324143631045](05晋级-springboot的自定义监控指标图片/image-20210324143631045.png)![image-20210324143703347](05晋级-springboot的自定义监控指标图片/image-20210324143703347.png)