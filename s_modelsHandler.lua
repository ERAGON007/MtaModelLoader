addEvent("modelLoader:getModelFiles", true)

addEventHandler("modelLoader:getModelFiles", resourceRoot,
function(thePlayer, modelIndex)
    if (thePlayer and modelIndex) then
        if not(isElement(thePlayer) and getElementType(thePlayer) == "player") then return end
        modelIndex = tonumber(modelIndex)
        if (not modelIndex) or (not _MODELS[modelIndex])then return end

        local txdFile = fileOpen("Models/" .. _MODELS[modelIndex].txdFileName, true)
        local dffFile = fileOpen("Models/" .. _MODELS[modelIndex].dffFileName, true)

        if not(txdFile and dffFile) then outputDebugString("couldn't load txd or dff file for " .. _MODELS[modelIndex].txdFileName .. " and " .. _MODELS[modelIndex].dffFileName, 1, 255, 0, 0) return end

        local colFile
        local col
        if (_MODELS[modelIndex].colFileName) then
            local col = fileOpen("Models/" .. _MODELS[modelIndex].colFileName, true)
            colFile = fileRead(col, fileGetSize(col))
        end

        triggerClientEvent(thePlayer, "modelLoader:loadOneModel", resourceRoot, fileRead(txdFile, fileGetSize(txdFile)), fileRead(dffFile, fileGetSize(dffFile)), _MODELS[modelIndex].objectId, colFile)
    
        fileClose(txdFile)
        fileClose(dffFile)

        if (col) then
            fileClose(col)
        end
    else
        outputDebugString("invalid arguments given for 'modelLoader:getModelFiles' Event (server-side)", 1, 255, 0, 0)
    end
end
)
