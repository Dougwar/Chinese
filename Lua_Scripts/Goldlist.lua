local cta = require 'cta'
local lfs = require 'lfs'

w = 0

local function findSentencesInDocument( filename, known, seen )
    local document = cta.Document( filename )
    for line in document:lines() do
        for sentence in line:sentences() do
        for word in sentence:words() do
		    if not known:contains( word ) then
                w = w + 1
				else
				w = w + 1	
             end
				
			end
			if 1 < w  then
				if w <= 5 then
					print ( sentence )	
				end
        end
		w = 0	
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
                end
            end
        end
    end
end

local known = cta.knownWords()
local seen = {}

local directory = cta.askUserForDirectory()

if directory ~= nil then
    traverseDirectory( directory, known, seen )
end
