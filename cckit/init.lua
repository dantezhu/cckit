cckit = cckit or {}

function cckit.fitScreen(node)
    node:setContentSize(cc.Director:getInstance():getVisibleSize())
    ccui.Helper:doLayout(node)
end

function cckit.seekNodeByTag(root, tag)
    if root:getTag() == tag then
        return root
    end

    for idx,child in ipairs(root:getChildren()) do
        local result = cckit.seekNodeByTag(child, tag)
        if result ~= nil then
            return result
        end
    end
    
    return nil
end

function cckit.seekNodeByName(root, name)
    if root:getName() == name then
        return root
    end

    for idx,child in ipairs(root:getChildren()) do
        local result = cckit.seekNodeByName(child, name)
        if result ~= nil then
            return result
        end
    end
    
    return nil
end

-- 仅注册一次
function cckit.scheduleScriptFuncOnce(callback, interval)
    -- 务必先定义local，否则在回调函数里面认不出来
    local schedEntry
    schedEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(
        function (...)
            -- print(string.format("callback: %s, schedEntry: %s", callback, schedEntry))
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedEntry)

            callback(...)
        end,
    interval, false)

    return schedEntry
end
