
xescale      = 1;
yescale      = 1;

estado       = noone;
temp_estado  = room_speed * 2;
timer_estado = 0;

vel          = 1;

destino_x    = x;
destino_y    = y;

sprite = sprite_index;

muda_estado = function(_estado)
{
    temp_estado--;
    timer_estado = irandom(temp_estado);

    if (timer_estado == temp_estado || temp_estado <= 0)
    {
        estado = _estado[irandom(array_length(_estado) - 1)];
        temp_estado = room_speed * 2; 
    }
}

desenha_sprite = function()
{
    draw_sprite_ext(sprite, sprite_index, x, y, xescale, yescale, image_angle, image_blend, image_alpha);
}

estado_parado = function()
{
    sprite = spCavaloP;
    muda_estado([estado_passeando, estado_parado]);
}

estado_passeando = function() 
{
    sprite = spCavaloA;

    if (destino_x == x && destino_y == y) 
    {
        var horizontal = irandom(1); 

        if (horizontal) {
            destino_x = oPlayer.x; 
            destino_y = y;
        } else {
            destino_x = x;
            destino_y = oPlayer.y; 
        }
    }
    else if (x == destino_x && y == destino_y) 
    {
        if (destino_x == x) {
            destino_x = oPlayer.x; 
        } else {
            destino_y = oPlayer.y; 
        }
    }

    // Direção para o destino
    var _dir = point_direction(x, y, destino_x, destino_y);

    // Mover na direção escolhida
    x += lengthdir_x(vel, _dir);
    y += lengthdir_y(vel, _dir);

    show_debug_message("PEAO");
    muda_estado([estado_parado, estado_passeando]);
}

estado = estado_parado;