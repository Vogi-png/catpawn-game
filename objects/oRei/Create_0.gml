// Inicialização das variáveis
estado       = noone;
temp_estado  = room_speed * 1;
timer_estado = 0;

destino_x    = x;
destino_y    = y;

vel          = 1;
hveloc       = 0;
vveloc       = 0;

xescale      = 1;
yescale      = 1;

sprite = sprite_index;

// Funções
muda_estado = function(_estado)
{
    temp_estado--;
    timer_estado = irandom(temp_estado);

    if (timer_estado == temp_estado || temp_estado <= 0)
    {
        estado = _estado[irandom(array_length(_estado)-1)];
        temp_estado  = room_speed * 5;
    }   
}

desenha_sprite = function()
{
    draw_sprite_ext(sprite, sprite_index, x, y, xescale, yescale, image_angle, image_blend, image_alpha);
}

estado_parado = function()
{
    sprite = spRei;
    muda_estado([estado_passeando, estado_parado]);
}

estado_passeando = function()
{
    sprite = spRei;

    destino_x = x + (x - oPlayer.x);
    destino_y = y + (y - oPlayer.y);

    var _dir = point_direction(x, y, destino_x, destino_y);
    
    var new_x = x + lengthdir_x(vel, _dir);
    var new_y = y + lengthdir_y(vel, _dir);
    
    if (new_x < 0) {
        new_x = 0;
    } else if (new_x > room_width - sprite_width) {
        new_x = room_width - sprite_width;
    }
    
    if (new_y < 0) {
        new_y = 0;
    } else if (new_y > room_height - sprite_height) {
        new_y = room_height - sprite_height;
    }

    if (!place_meeting(new_x, new_y, oBlock)) {
        x = new_x;
        y = new_y;
    } else {
        _dir += 90; // Tente mudar a direção
        new_x = x + lengthdir_x(vel, _dir);
        new_y = y + lengthdir_y(vel, _dir);

        if (!place_meeting(new_x, new_y, oBlock)) {
            x = new_x;
            y = new_y;
        }
    }
    
    show_debug_message("REI FUGINDO");
    muda_estado([estado_parado, estado_passeando]);
}

estado = estado_parado;
