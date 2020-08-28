local cta = require 'cta'
local lfs = require 'lfs'

uw = 0
kw = 0


local function findSentencesInDocument( filename, known, seen )
    local document = cta.Document( filename )
    for line in document:lines() do
        for sentence in line:sentences() do
        for word in sentence:words() do
		    if not known:contains( word ) then
                uw = uw + 1
				else
					kw = kw + 1
             end
				 
        end
    end
end
 end


local function traverseDirectory( directory, known, seen )
    for file in lfs.dir( directory ) do
        if file ~= "." and file ~= ".." then

            local fullPath = directory .. '/' .. file
            local mode = lfs.attributes( fullPath, 'mode' )

            if mode == "directory" then
                traverseDirectory( fullPath )
            elseif mode == "file" then
                if file:match( "%.txt$" ) then
                    findSentencesInDocument( fullPath, known, seen )
					totalword = kw+uw
					knowpercent =  math.floor((kw / totalword) * 100)
					print (file,";", totalword,";" ,kw,";", knowpercent ,"%" )
					uw = 0
					kw = 0
					
                end
            end
        end
    end
end

local known = cta.knownWords()
local seen = {}

local directory = cta.askUserForDirectory()
print ("File Name",";","Total Words",";" ,"Know Words",";", "% Know" ,"%" )
if directory ~= nil then
    traverseDirectory( directory, known, seen )
end