estado       = noone;
temp_estado  = room_speed * 1; // Reduzindo o tempo de estado parado pela metade
timer_estado = 0;

destino_x    = x;
destino_y    = y;

vel          = 0.5;

xescale      = 1;
yescale      = 1;

sprite = sprite_index;

muda_estado = function(_estado)
{
    temp_estado--;
    timer_estado = irandom(temp_estado);

    if (timer_estado == temp_estado || temp_estado <= 0)
    {
        estado = _estado[irandom(array_length(_estado)-1)];
        temp_estado  = room_speed * 5; // Reduzindo o tempo de estado parado pela metade novamente
    }   
}

desenha_sprite = function()
{
    draw_sprite_ext(sprite, sprite_index, x, y, xescale, yescale, image_angle, image_blend, image_alpha);
}

estado_parado = function() // inimigo parado
{
    sprite = spPeaoP;
    muda_estado ([estado_passeando, estado_parado]);
}

estado_passeando = function() // inimigo andando
{
    sprite = spPeaoA;

    // Define o destino do peão como a posição atual do jogador
    destino_x = oPlayer.x;
    destino_y = oPlayer.y;

    // Calcula a direção em direção ao destino
    var _dir = point_direction(x, y, destino_x, destino_y);
    
    // Move o peão na direção do destino
    x += lengthdir_x(vel, _dir);
    y += lengthdir_y(vel, _dir);
    
    show_debug_message("PEAO")
    muda_estado ([estado_parado, estado_passeando]);
}

estado = estado_parado;
