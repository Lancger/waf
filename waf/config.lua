--WAF config file,enable = "on",disable = "off"

--waf status
config_waf_enable = "on"
--log dir 注意需要放到这个目录，不然会出现诡异的日志不记录的问题
config_log_dir = "/usr/local/openresty/nginx/logs"
--rule setting
config_rule_dir = "/usr/local/openresty/nginx/conf/waf/rule-config"
--enable/disable white url
config_white_url_check = "on"
--enable/disable white ip
config_white_ip_check = "on"
--enable/disable block ip
config_black_ip_check = "on"
--enable/disable url filtering
config_url_check = "on"
--enalbe/disable url args filtering
config_url_args_check = "on"
--enable/disable user agent filtering
config_user_agent_check = "on"
--enable/disable cookie deny filtering
config_cookie_check = "on"
--enable/disable cc filtering
config_cc_check = "on"
--cc rate the xxx of xxx seconds
config_cc_rate = "10/60"
--enable/disable post filtering
config_post_check = "on"
--config waf output redirect/html
config_waf_output = "html"
--if config_waf_output ,setting url
config_waf_redirect_url = "https://www.baidu.com"

config_output_html = [[
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>访问拦截 - 安全警告</title>
    <!-- 引入Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(120deg, #2b2b2b, #1e1e1e);
            color: #ffffff;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }

        .container {
            background: rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            text-align: center;
            max-width: 600px;
        }

        h1 {
            color: #ff4c4c;
            animation: pulse 2s infinite;
        }

        .icon {
            width: 80px;
            height: 80px;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="https://img.icons8.com/ios-filled/80/ff4c4c/shield.png" alt="安全图标" class="icon">
        <h1>访问拦截</h1>
        <p>您的请求已被安全系统拦截。</p>
        <p>请检查您的请求是否包含非法内容，或联系网站管理员获取更多信息。</p>
        <div class="user-info">
            <p>访问IP: <!-- 在这里插入用户IP，例如： -->{{USER_IP}}</p>
            <p>访问UUID: <!-- 在这里插入UUID，例如： -->{{UUID}}</p>
        </div>
        <a href="mailto:admin@example.com" class="btn btn-danger mt-3">联系管理员</a>
    </div>

    <!-- 引入Bootstrap JS和依赖 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
]]

