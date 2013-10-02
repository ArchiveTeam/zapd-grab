-- based on xanga-grab

local url_count = 0
local new_url_count = 0

read_file = function(file)
    if file then
        local f = io.open(file)
        local data = f:read("*all")
        f:close()
        return data
    else
        return ""
    end
end

wget.callbacks.get_urls = function(file, url, is_css, iri)
    -- progress message
    url_count = url_count + 1
    if url_count % 5 == 0 then
        io.stdout:write("\r - Downloaded "..url_count.." URLs. Discovered "..new_url_count.." URLs")
        io.stdout:flush()
    end
    
    
    if string.match(url, "zapd.com") then
        local urls = {}
        local html = read_file(file)
        
        for url in string.gfind(html, "https?://[%w%._-]+%.cloudfront%.net/[%w%./_-]+") do
            table.insert(urls, { url=url })
            new_url_count = new_url_count + 1
        end
        return urls
    end
end
