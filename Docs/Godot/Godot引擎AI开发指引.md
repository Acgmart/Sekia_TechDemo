# 使用AI进行游戏开发
选择开源引擎Godot
选择本地大模型Qwen3.6或者Chatgpt5.4等模型
参考视频：
1.烟雨：2026独立游戏引擎选择与个人发展建议
https://www.bilibili.com/video/BV15cDCBuEru
烟雨：轻量级游戏引擎与AI辅助开发工作流的深度解析：基于VS Code与Claude Code的自动化原型验证与移动端构建方案
https://www.lfzxb.top/aigc-gameplay-demo-dev/
Godot在以下项目中有优势：
场景/预制体可读性：基于TOML配置文件标准，场景是.tscn 资源是.tres，便于AI阅读和无损修改。
场景结构：使用节点树，容易被AI理解和修改。
代码生成稳定性：gdscript对AI更好，C#是否也可以用？

# Godot相关的模型上下文协议（MCP）
godot-mcp/godot-mcp-pro：提供数百个细分工具，支持场景创建、节点增删、属性修改等。AI可以通过标准工具调用，在不破坏 .tscn 语法的情况下安全地搭建场景。
godot-mcp-runtime：运行时干预与视觉反馈闭环，由AI完成写代码-启动游戏-模拟玩家操作-截图-分析迭代。
学习掌握这些mcp

# MemOS持久化记忆操作系统 减少Token消耗避免上下文过长
安装MemOS MCP插件：mem0-mcp-selfhosted

# 打包发布
先完成初次使用命令行打包
godot --headless --export-release "Android" /builds/game_demo.apk
godot：生成godot环境变量
headless：无头模式
"Android"：目标平台
/builds/game_demo.apk：目标路径
看看怎么在Mac中安装启动应用

# GamePlay 多玩玩别人的创意demo 寻找核心机制
itch.io：目前全球最大的独立游戏、实验性游戏和 Game Jam 作品托管平台。强烈建议你多浏览带有 `experimental`（实验性）或 `innovative-game`（创新游戏）标签的免费网页游戏 ``。这里的游戏往往体量极小，但核心玩法极具启发性。
Game Jolt：拥有 15 年历史的独立游戏平台，有大量免费的粉丝游戏、原型演示和网页小游戏，非常适合寻找轻量级的灵感 。
PICO-8 BBS (Lexaloffle)：这是一个“幻想主机”的官方社区，所有游戏都必须在极其严苛的代码体积、内存和 16 色像素限制下完成。这种限制逼迫开发者只能在最核心的 Gameplay 机制上做创新，是获取纯粹玩法点子的绝佳宝库``。
Kongregate / Newgrounds：虽然是老牌的网页/Flash 游戏门户，但至今仍是寻找“单一机制（Single-mechanic）”休闲游戏和硬核小游戏的好去处``。

# Godot在Mac平台实践
1.使终端工具支持代理 仅在子shell进程中生效
打开～/.zshrc在文件中添加下面两行，根据代理软件修改端口：
alias daili="export ALL_PROXY=socks5://127.0.0.1:7897"
alias unsdaili="unset ALL_PROXY"
这样就可以在终端通过daili和undaili命令来开启关闭代理
验证代理是否生效，运行以下命令：
curl ifconfig.me

1.创建Godot环境变量
https://docs.godotengine.org/en/latest/tutorials/editor/command_line_tutorial.html
要实现在Mac上用godot命令需要使用brew安装
brew install godot-mono
这样会得到godot-mono命令，可以用alias映射为godot
在～/.zshrc文件中加入一行：
alias godot=godot-mono

2.安装godot-mcp
https://github.com/Coding-Solo/godot-mcp
命令行执行安装命令：
claude mcp add godot -- npx @coding-solo/godot-mcp
也可以用带环境变量的版本：
claude mcp add godot -e GODOT_PATH=/Applications/Godot_mono.app/Contents/MacOS/Godot -e DEBUG=true -- npx @coding-solo/godot-mcp
环境变量可以在~/.claude.json中编辑，在“env”的大括号中加入两行：
"GODOT_PATH": "/Applications/Godot_mono.app/Contents/MacOS/Godot",
"DEBUG": "true"