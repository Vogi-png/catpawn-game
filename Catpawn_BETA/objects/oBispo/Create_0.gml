xescale      = 1;
yescale      = 1;

estado       = noone;
temp_estado  = room_speed * 2;
timer_estado = 0;

vel          = 1;

destino_x    = x;
destino_y    = y;

sprite = sprite_index;


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



// arrumando profundidade
desenha_sprite = function()
{
    draw_sprite_ext(sprite, sprite_index, x, y, xescale, yescale, image_angle, image_blend, image_alpha);
}



estado_parado = function() // inimigo parado
{
    sprite = spBispoP;

    muda_estado([estado_passeando, estado_parado]);
}

estado_passeando = function() // inimigo andando
{
    sprite = spBispoA;

    var _dist = point_distance(x, y, destino_x, destino_y);
    if (_dist < 10)
    {
        var valid_destination = false;
        var max_attempts = 10; // Tentativas máximas para encontrar um destino válido
        while (!valid_destination && max_attempts > 0)
        {
            var dir = choose(45, 135, 225, 315);
            var distance = random(100) + 50; // Distância aleatória entre 50 e 150 pixels

            destino_x = x + lengthdir_x(distance, dir);
            destino_y = y + lengthdir_y(distance, dir);

            // Verifica se o destino está dentro dos limites da sala
            if (destino_x >= 0 && destino_x <= room_width && destino_y >= 0 && destino_y <= room_height)
            {
                valid_destination = true;
            }
            max_attempts--;
        }
        
        // Se não encontrou um destino válido após várias tentativas, redefine para a posição atual
        if (!valid_destination)
        {
            destino_x = x;
            destino_y = y;
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
