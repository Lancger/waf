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
config_waf_redirect_url = "https://www.unixhot.com"
config_output_html=[[
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>访问被拦截</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            text-align: center;
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            max-width: 600px;
        }
        h1 {
            color: #e74c3c;
            margin-bottom: 20px;
        }
        p {
            margin: 20px 0;
            line-height: 1.6;
        }
        .icon {
            font-size: 50px;
            color: #3498db;
            margin-bottom: 20px;
        }
        .footer {
            font-size: 12px;
            color: #888;
        }
        .footer a {
            color: #3498db;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">
            <i class="fas fa-shield-alt"></i>
        </div>
        <h1>访问被拦截</h1>
        <p>很抱歉，您提交的请求可能对网站造成威胁，请求已被管理员设置的策略阻断。</p>
        <p>您的访问IP为：<strong>{{USER_IP}}</strong></p>
        <p class="footer">
            本页面为默认提示页面，如有疑问请联系网站管理员并提供UUID信息。
            <br>您的请求UUID为：<strong>1234-5678-ABCD-EFGH</strong>
        </p>
    </div>
</body>
</html>
]]

