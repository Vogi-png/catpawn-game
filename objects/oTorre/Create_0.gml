xescale      = 1;
yescale      = 1;

estado       = noone;
temp_estado  = room_speed * 2;
timer_estado = 0;

vel          = 2;

destino_x    = x;
destino_y    = y;

sprite = sprite_index;

// arrumando profundidade
desenha_sprite = function()
{
    draw_sprite_ext(sprite, sprite_index, x, y, xescale, yescale, image_angle, image_blend, image_alpha);
}

muda_estado = function(_estado) // estado parado ou passeando no aleatório
{
    temp_estado--;
    timer_estado = irandom(temp_estado);

    if (timer_estado == temp_estado || temp_estado <= 0)
    {
        estado = _estado[irandom(array_length(_estado) - 1)];
        temp_estado = room_speed * 10;
    }
}

estado_parado = function() // inimigo parado
{
    sprite = spTorreP;
    muda_estado([estado_passeando, estado_parado]);
}

estado_passeando = function() // inimigo andando
{
	image_speed = 1;
    sprite = spTorreA;

    var _dist = point_distance(x, y, destino_x, destino_y);
    if (_dist < 10)
    {
        // Decide aleatoriamente se o próximo movimento será horizontal ou vertical
        if (irandom(1) == 0)
        {
            // Movimento horizontal
            destino_x = random(room_width);
            destino_y = y;
        }
        else
        {
            // Movimento vertical
            destino_x = x;
            destino_y = random(room_height);
        }
    }

    // Direção para o destino
    var _dir = point_direction(x, y, destino_x, destino_y);

    // Mover na direção escolhida
    x += lengthdir_x(vel, _dir);
    y += lengthdir_y(vel, _dir);

    show_debug_message("TORRE");
    muda_estado([estado_parado, estado_passeando]);
}

estado = estado_parado;
