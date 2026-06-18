Items                  = {}
local DataStoresIndex  = {}
local DataStores       = {}
local SharedDataStores = {}

function MakeDataStore(plate)
  local data = {}
  local dataStore   = CreateTrunkDataStore(plate, data)
  SharedDataStores[plate] = dataStore
end


function GetTrunkSharedDataStore(plate)
  if SharedDataStores[plate] == nil then
    MakeDataStore(plate)
  end
  return SharedDataStores[plate]
end

AddEventHandler('truck:getSharedDataStore', function(plate,cb)
  cb(GetTrunkSharedDataStore(plate))
end)
