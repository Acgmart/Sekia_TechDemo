# 提示词
setup the software in this repo
https://github.com/myhhub/stock
the readme in the repo describes multiple ways to set up the software，use MacOS.

# 安装Docker app
brew install --cask docker
这个时候程序目录出现Docker图标，可以手动运行，也可以代码运行：
open -a Docker

# 创建本地常驻文件
mkdir -p "$HOME/instock-data/mariadb/data"
touch "$HOME/instock-data/instockproxy.txt"
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
  -v "$HOME/instock-data/instockproxy.txt:/data/InStock/instock/config/proxy.txt" \
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
python basic_data_after_close_daily_job.py 2026-05-08

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