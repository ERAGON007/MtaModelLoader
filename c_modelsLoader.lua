local localPlayer = getLocalPlayer()

local function loadOneModel(txdFile, dffFile, objectIdToReplace, colFile)
    if (txdFile and dffFile and objectIdToReplace) then
        local theTxd = engineLoadTXD(txdFile)
        local theDff = engineLoadDFF(dffFile)

        if not(theTxd and theDff) then outputDebugString("func loadOneModel failed to LOAD txd or dff files!", 1, 255, 0, 0) return end

        local replacement = engineReplaceModel(theDff, objectIdToReplace)
        local txdImport = engineImportTXD(theTxd, objectIdToReplace)

        if not(theTxd and theDff) then outputDebugString("func loadOneModel failed to REPLACE txd or dff files!", 1, 255, 0, 0) return end

        if (colFile) then
            local theCol = engineLoadCOL(colFile)
            if (not theCol) then outputDebugString("func loadOneModel failed to LOAD collision file!", 1, 255, 0, 0) return end

            local colReplacement = engineReplaceCOL(theCol, objectIdToReplace)

            if (not theCol) then outputDebugString("func loadOneModel failed to REPLACE collision file!", 1, 255, 0, 0) return end
        end
    else
        outputDebugString("func loadOneModel got invalid arguments!", 1, 255, 0, 0)
    end
end

addEvent("modelLoader:loadOneModel", true)
addEventHandler("modelLoader:loadOneModel", resourceRoot, loadOneModel)

local function loadAllModels()
    for _, modelObject in ipairs(_MODELS) do
        if (modelObject.dontCache) then
            triggerServerEvent("modelLoader:getModelFiles", resourceRoot, localPlayer, _)
            return
        end

        loadOneModel(modelObject.txdFileName, modelObject.dffFileName, modelObject.objectId, modelObject.colFileName)
    end
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), loadAllModels)
