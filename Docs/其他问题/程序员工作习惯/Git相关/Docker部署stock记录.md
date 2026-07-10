# 提示词
setup the software in this repo
https://github.com/myhhub/stock
the readme in the repo describes multiple ways to set up the software，use MacOS.

# 安装Docker app
新建命令行窗口，开启代理。
brew install --cask docker
这个时候程序目录出现Docker图标，可以手动运行，也可以代码运行：
open -a Docker

# 创建本地常驻文件
mkdir -p "$HOME/instock-data/mariadb/data"
touch "$HOME/instock-data/eastmoneycookie.txt"

# 创建Docker容器
## Create Docker network
docker network create InStockService

## Start MariaDB
docker run -d --name InStockDbService \
  --network InStockService \
  -v "$HOME/instock-data/mariadb/data:/var/lib/mysql" \
  -e MARIADB_ROOT_PASSWORD=root \
  mariadb:latest
拉取Mariadb失败时需要添加专用的源，用完去掉，Docker Desktop → Settings → Docker Engine：
"registry-mirrors": [
    "https://docker.m.daocloud.io"
  ]

## 给本地仓库脚本可执行权限
ls -l /Users/sekia/Desktop/Git/stock/instock/bin/*.sh
chmod +x /Users/sekia/Desktop/Git/stock/instock/bin/run_job.sh
chmod +x /Users/sekia/Desktop/Git/stock/instock/bin/run_web.sh
chmod +x /Users/sekia/Desktop/Git/stock/instock/bin/run_cron.sh
chmod +x /Users/sekia/Desktop/Git/stock/instock/bin/restart_web.sh

## Start InStock
docker run -dit --name InStock \
  --network InStockService \
  -p 9988:9988 \
  -v /Users/sekia/Desktop/Git/stock:/data/InStock \
  -v "$HOME/instock-data/stocklist.txt:/data/InStock/instock/config/stocklist.txt" \
  -v "$HOME/instock-data/eastmoneycookie.txt:/data/InStock/instock/config/eastmoney_cookie.txt" \
  -e db_host=InStockDbService \
  mayanghua/instock:latest

# 运行项目
浏览器打开：http://localhost:9988/

# 查看容器日志
docker logs -f InStock
docker logs -f InStockDbService

# 执行任务
docker exec -it InStock bash
cd /data/InStock/instock/job
python basic_data_after_close_daily_job.py
或者
docker exec -it InStock bash -lc 'cd /data/InStock/instock/job && python basic_data_daily_job.py'

# 解决两个容器没连接到同一个Docker网络的问题
docker network create InStockService 2>/dev/null || true
docker network connect InStockService InStockDbService 2>/dev/null || true
docker network connect InStockService InStock 2>/dev/null || true
docker restart InStockDbService
docker restart InStock

# 关键文件
instock/job/execute_daily_job.py              # 总调度
instock/job/basic_data_after_close_daily_job.py
instock/core/stockfetch.py                    # 数据抓取入口聚合
instock/lib/database.py                       # 数据库连接和写入
instock/lib/run_template.py                   # 日期参数/批量执行模板
instock/core/tablestructure.py                # 表结构定义

# 重启docker
docker restart InStock

# 系统运行日志
stock_execute_job.log
docker exec -it InStock bash -lc 'tail -n 100 /data/InStock/instock/log/stock_execute_job.log'

# 设东方财富Cookie
1、获取Cookie
    打开浏览器，访问东方财富网行情页面：https://quote.eastmoney.com/center/gridlist.html#hs_a_board
    登录账号（如果有东方财富网账号，建议登录以获取更稳定的Cookie）
    打开开发者工具（F12）：
    切换到Network（网络）选项卡
    刷新页面（按 F5 或点击浏览器刷新按钮）
    选择任意请求：在网络请求列表中，选择任意一个请求（“get？”开头，建议选择URL包含 push2.eastmoney.com 的请求）
    查看Cookie：在请求详情中，找到 Request Headers（请求头）部分，复制完整的 Cookie 值
    保存Cookie：将复制的Cookie值保存下来，稍后使用
2、设置Cookie
    编辑eastmoney_cookie.txt文件，替换Cookie。
3、注意事项
    Cookie有效期：东方财富网的Cookie通常会在一段时间后过期（一般为几天到几周），如突然无法正常工作，可能是Cookie过期了，需要重新获取并设置
    定期更新：建议每隔一段时间（如每周）更新一次Cookie，以确保爬取的稳定性
    多账号轮换：如果有多个东方财富网账号，可以轮换使用不同账号的Cookie，进一步降低被限制的风险
