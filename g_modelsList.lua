_MODELS = {
    --[[
        format: {txdFileName = "", dffFileName = "", objectId = objectIdToReplace, dontCache = bool, colFileName = ""}

        if dontCahce is true then the file won't be saved in client disk as cache and will be downloaded everytime the client connects

        NOTE: the files txd AND dff SHOULD be as the same name
    ]]
    {txdFileName = "test.txd", dffFileName = "test.dff", objectId = 1576, dontCache = true, colFileName = "test.col"},
}
