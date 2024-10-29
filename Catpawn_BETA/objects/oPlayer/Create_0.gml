/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
window_set_size(1280,720)
flor      = 0;
vida = 0;

estado = "parado";

direita   = 0;
esquerda  = 0;
cima      = 0;
baixo     = 0;

dir       = 0;

hveloc    = 0;
vveloc    = 0;
veloc     = 1;

item = noone;


controles = function() // movimento
{
	direita     = keyboard_check(ord("D")) or keyboard_check(vk_right);
    esquerda    = keyboard_check(ord("A")) or keyboard_check(vk_left);
    cima        = keyboard_check(ord("W")) or keyboard_check(vk_up);
    baixo       = keyboard_check(ord("S")) or keyboard_check(vk_down);

    //hveloc = (direita - esquerda) * veloc;
    //vveloc = (baixo - cima) * veloc;
	var _dir = point_direction(0,0,direita - esquerda, baixo - cima);
	
	if (direita xor esquerda or baixo xor cima)
	{	
	    hveloc = lengthdir_x(veloc,_dir);
	    vveloc = lengthdir_y(veloc,_dir);
	} 
	
	else 
	{
		vveloc = 0;
		hveloc = 0;
	}
}



maquina_estados = function() // estado do objeto
{
	switch(estado)
	{
		case "parado": // sem animação
		image_speed = 1;
		
		if (direita xor esquerda or baixo xor cima){
			estado = "movendo";
		}
		break;
		
		case "movendo": // com animação
		image_speed = 1;
		
		if (!direita and !esquerda and !baixo and !cima){
			estado = "parado";
		}
		break;
	}
}



muda_sprite = function() // animação
{
	if (direita xor esquerda or baixo xor cima){
	    dir = point_direction(0,0,direita - esquerda, baixo - cima);
	}
	
	switch(dir){
		case 0: 
		sprite_index = spPlayerAD; 
		if (estado = "parado"){
			sprite_index = spPlayerD
		}
		break;
		case 90: 
		sprite_index = spPlayerAT; 
		if (estado = "parado"){
			sprite_index = spPlayerT
		}
		break;
		case 180: 
		sprite_index = spPlayerAE; 
		if (estado = "parado"){
			sprite_index = spPlayerE
		}
		break;
		case 270: 
		sprite_index = spPlayerAF; 
		if (estado = "parado"){
			sprite_index = spPlayerP
		}
		break;
	}
}



estado_persegue = function(){ // inimigo perseguir
	
}