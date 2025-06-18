if ( index == 0){
	
	audio_stop_sound(Sound5);
	audio_play_sound(sNivelA, 1, true);
	room_goto_next()
}
if ( index == 1){
	game_end()
}