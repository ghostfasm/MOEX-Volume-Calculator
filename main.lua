dofile(getScriptPath().."\\dataStorage.lua")
dofile(getScriptPath().."\\dll_Robot.lua")


is_run = true
Timer = 3
FileData = getScriptPath().."\\BOT1_DATA.txt"
------------------------------------------------------------------------------
FileAverageData = nil
someData = os.date("%Y-%m-%d %H-%M-%S")
FileAverageData = getScriptPath().."\\Result " ..  someData .. ".txt"
Problem = ""

-----------------------------------
Class = "TQBR"


function OnInit()

	-- TableID = AllocTable() 
	-- AddColumn(TableID, Columns._Ticker, "Тикер", true, QTABLE_STRING_TYPE, 15)
	-- AddColumn(TableID, Columns._AverageVolume, "Av-Volume", true, QTABLE_STRING_TYPE, 20)


		
	-- CreateWindow(TableID)
	-- -- EmitentsInitialization()
	-- -- PutDataToTableInit()

end

function main()
	if is_run == true then
		Body()
	end
end


function OnStop()
	is_run = false
	DestroyTable(TableID)
end


