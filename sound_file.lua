--MUSIC 
menuMusic = audio.loadStream( "audio/menu/Bone-Yard-Waltz-Menu.mp3")
gameMusic = audio.loadStream( "audio/game/The-Crypt.wav")
gameOverMusic = audio.loadStream( "audio/game_over/game_over.mp3" )

--SOUND
gameOverSound = audio.loadSound( "audio/game_over/evil.mp3" )
 
audio.reserveChannels (2) 

function playSFX (soundfile) 
	audio.play(soundfile, {channel =  2})
end 
 
function playGameMusic(soundfile)
	audio.play (soundfile, {channel = 1, loops = -1 , fadein=2500})	
end
 
function resetMusic (soundfile)
 
if musicisOn == true then 
	audio.stop(1)
	audio.rewind (gamebgmusic)
end
 
end
 
function pauseMusic (soundfile)
	if musicisOn == true then 
		audio.pause()
	end
end
 
function resumeMusic (channel)
	if musicisOn == true then 
		audio.resume(channel)
	end
end