currentTime = 0

-- the number of digits in a number
local function countOfDigits(n)
    r = 0
	while (n > 1) do
		n = n / 10
		r = r + 1
	end
	return r
end

function getVolumeByTicker(ticker)
	local averageVolume = 0
	-- local zeroesCount = 3
	ds, Error = CreateDataSource (Class, ticker, INTERVAL_D1);
	while (Error == "" or Error == nil) and ds:Size() == 0 do sleep(1) end
	if Error ~= "" and Error ~= nil then message("Chart connection error: "..Error) end
	for i = 1, 10 do
		local V = ds:V(ds:Size() + 1 - i); -- Получить значение Volume для указанной свечи (объем сделок в свече)
		averageVolume = averageVolume + ((V / 10) * 1/100);
	end

	averageVolume = math.ceil(averageVolume - averageVolume % 10 ^ (countOfDigits(averageVolume) // 2))
	WriteToEndOfFile(FileAverageData, ticker .. "\t" .. averageVolume .. "\t" .. averageVolume * 2)
end

function Body() -- Основные вычисления
	currentTime = getInfoParam("SERVERTIME")
	currentHourValue, currentMinValue, currentSecValue = currentTime:match("(%d+):(%d+):(%d+)")


	if (IsWindowClosed(TableID)) then
		CreateWindow(TableID)
		-- PutDataToTableInit()
	end

	for i = 1, #Emitents do
		getVolumeByTicker(Emitents[i])
	end

	message("Done")

end


function WriteToEndOfFile(sFile, sDataString)
	sDataString = sDataString.."\n"
	local f = io.open(sFile, "r+")
	if (f == nil) then
		f = io.open(sFile, "w")
	end
	if (f ~= nil) then
		f:seek("end", 0) -- устанавливает в определенном месте файла курсор
		f:write(sDataString)
		f:flush() -- сохранение
		f:close()
	end
end
