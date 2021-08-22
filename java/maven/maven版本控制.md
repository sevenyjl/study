# Maven版本统一

> 需求：父版本从1.0.0迭代到1.1.0
>
> 原来：改每个pom的version信息
>
> 目的：只需要改父的version信息，全部都修改了

1.Demo构建

- 父子工程的maven架构的demo

  结构如下：![image-20210329160012647](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210329160012647.png)

- 第三方引用的demo

  ![image-20210329160114860](https://sevenpic.oss-cn-beijing.aliyuncs.com/img/image-20210329160114860.png)

2.maven的pom配置

父项目pom配置

```xml
	<!--引用父亲工程的版本-->    
	<version>${maven.father.version}</version>
    <packaging>pom</packaging>
    <properties>
        <!--父亲pom的版本--><maven.father.version>1.0.0</maven.father.version>
    </properties>
<!--只是为了方便子项目引用-->
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>com.seven</groupId>
                <artifactId>son-api</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.seven</groupId>
                <artifactId>son-commmon</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.seven</groupId>
                <artifactId>son-server</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.seven</groupId>
                <artifactId>son-xxxx</artifactId>
                <version>${project.version}</version>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <!--打包插件-->
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <source>${java.version}</source>
                    <target>${java.version}</target>
                    <testSource>${java.version}</testSource>
                    <testTarget>${java.version}</testTarget>
                </configuration>
                <version>3.8.1</version>
            </plugin>
            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>flatten-maven-plugin</artifactId>
                <version>1.1.0</version>
                <configuration>
                    <!--                    是否更新pom文件，此处还有更高级的用法-->
                    <updatePomFile>true</updatePomFile>
                    <flattenMode>resolveCiFriendliesOnly</flattenMode>
                </configuration>
                <executions>
                    <execution>
                        <id>flatten</id>
                        <phase>process-resources</phase>
                        <goals>
                            <goal>flatten</goal>
                        </goals>
                    </execution>
                    <execution>
                        <id>flatten.clean</id>
                        <phase>clean</phase>
                        <goals>
                            <goal>clean</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
```

子项配置

```xml
    <parent>
        <artifactId>demo-maven-father</artifactId>
        <groupId>com.seven</groupId>
        <version>${maven.father.version}</version>
    </parent>
```

3.执行打包

```sh
mvn clean install
```

4.第三方引用

pom配置：

```xml
    <dependencies>
        <dependency>
            <groupId>com.seven</groupId>
            <artifactId>son-api</artifactId>
            <version>1.0.0</version>
        </dependency>
    </dependencies>
```

5.效果演示

<video id="video" controls=""src="maven版本控制图片/20210330_102508.mp4" preload="none">

> demo：https://gitee.com/GTeam_seven/demo-maven-father