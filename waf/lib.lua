--waf core lib
require 'config'

-- Get the client IP
function get_client_ip()
    local client_ip = ngx.req.get_headers()["X_real_ip"]
    if client_ip == nil then
        client_ip = ngx.req.get_headers()["X_Forwarded_For"]
    end
    if client_ip == nil then
        client_ip = ngx.var.remote_addr
    end
    if client_ip == nil then
        client_ip = "unknown"
    end
    return client_ip
end

-- Get the client user agent
function get_user_agent()
    local user_agent = ngx.var.http_user_agent
    if user_agent == nil then
       user_agent = "unknown"
    end
    return user_agent
end

-- Get WAF rule
function get_rule(rulefilename)
    local io = require 'io'
    local RULE_PATH = config_rule_dir
    local RULE_FILE = io.open(RULE_PATH..'/'..rulefilename, "r")
    if RULE_FILE == nil then
        return
    end
    local RULE_TABLE = {}  -- Declare RULE_TABLE as a local variable
    for line in RULE_FILE:lines() do
        table.insert(RULE_TABLE, line)
    end
    RULE_FILE:close()
    return RULE_TABLE
end

-- Function to generate a random UUID
function generate_uuid()
    local random = math.random
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 15) or random(8, 11)
        return string.format('%x', v)
    end)
end

--WAF log record for json,(use logstash codec => json)
function log_record(method, url, data, ruletag)
    local cjson = require("cjson")
    local io = require 'io'
    local LOG_PATH = config_log_dir
    local CLIENT_IP = get_client_ip()
    local USER_AGENT = get_user_agent()
    local SERVER_NAME = ngx.var.server_name
    local LOCAL_TIME = ngx.localtime()
    local UUID = generate_uuid()  -- Generate a UUID for the log entry

    local log_json_obj = {
        client_ip = CLIENT_IP,
        local_time = LOCAL_TIME,
        server_name = SERVER_NAME,
        user_agent = USER_AGENT,
        attack_method = method,
        req_url = url,
        req_data = data,
        rule_tag = ruletag,
        uuid = UUID  -- Include the UUID in the log
    }

    local LOG_LINE = cjson.encode(log_json_obj)
    local LOG_NAME = LOG_PATH..'/'..SERVER_NAME..'_'..ngx.today()..".log"  -- Use full server name in log file name
    local file = io.open(LOG_NAME, "a")
    if file == nil then
        return
    end
    file:write(LOG_LINE.."\n")
    file:flush()
    file:close()
end

-- WAF return
function waf_output()
    local user_ip = get_client_ip()  -- Get the client's IP address
    local uuid = generate_uuid()  -- Generate a random UUID
    local output_html = config_output_html:gsub("{{USER_IP}}", user_ip):gsub("{{UUID}}", uuid)  -- Replace placeholders

    if config_waf_output == "redirect" then
        ngx.redirect(config_waf_redirect_url, 301)
    else
        ngx.header.content_type = "text/html"
        ngx.status = ngx.HTTP_FORBIDDEN
        ngx.say(output_html)
        ngx.exit(ngx.status)
    end
end