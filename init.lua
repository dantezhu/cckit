--=============================================================================
--
--     FileName: init.lua
--         Desc: 
--
--       Author: dantezhu
--        Email: dantezhu@qq.com
--     HomePage: http://www.vimer.cn
--
--      Created: 2015-03-16 14:54:19
--      Version: 0.0.1
--      History:
--               0.0.1 | dantezhu | 2015-03-16 14:54:19 | init
--
--=============================================================================

neon_utils = neon_utils or {}

function neon_utils.fit_full_screen(node)
    local resolutionPolicy = cc.Director:getInstance():getOpenGLView():getResolutionPolicy()
    local resolutionSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

    assert(resolutionPolicy == cc.ResolutionPolicy.FIXED_WIDTH or resolutionPolicy == cc.ResolutionPolicy.FIXED_HEIGHT)
    -- 真实设备分辨率只能这样获取
    -- getWinSize 之类在调用完 setDesignResolutionSize 之后就完全不对了
    local frameSize = cc.Director:getInstance():getOpenGLView():getFrameSize()
    
    if resolutionPolicy == cc.ResolutionPolicy.FIXED_WIDTH then
        -- 务必计算比例，因为是 FIX_WIDTH，所以以设计WIDTH为准算出HEIGHT
        node:setContentSize(cc.size(resolutionSize.width, frameSize.height * resolutionSize.width / frameSize.width))
    else
        node:setContentSize(cc.size(frameSize.width * resolutionSize.height / frameSize.height, resolutionSize.height))
    end

    ccui.Helper:doLayout(node)
end

function neon_utils.seekNodeByTag(root, tag)
    if root:getTag() == tag then
        return root
    end

    for idx,child in ipairs(root:getChildren()) do
        local result = neon_utils.seekNodeByTag(child, tag)
        if result ~= nil then
            return result
        end
    end
    
    return nil
end

function neon_utils.seekNodeByName(root, name)
    if root:getName() == name then
        return root
    end

    for idx,child in ipairs(root:getChildren()) do
        local result = neon_utils.seekNodeByName(child, name)
        if result ~= nil then
            return result
        end
    end
    
    return nil
end
