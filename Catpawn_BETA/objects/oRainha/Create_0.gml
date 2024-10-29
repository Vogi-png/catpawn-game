// Inicialização das variáveis
estado       = noone;
temp_estado  = room_speed * 1; // Reduzindo o tempo de estado parado pela metade
timer_estado = 0;

destino_x    = x;
destino_y    = y;

vel          = 1.5;

hveloc = 0;
vveloc = 0;

xescale      = 1;
yescale      = 1;

sprite = sprite_index;

// Função para mudar o estado do rei
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

// Função para desenhar o sprite do rei
desenha_sprite = function()
{
    draw_sprite_ext(sprite, sprite_index, x, y, xescale, yescale, image_angle, image_blend, image_alpha);
}

// Estado do rei parado
estado_parado = function() // inimigo parado
{
    sprite = spRainha;
    muda_estado([estado_passeando, estado_parado]);
}

// Estado do rei passeando (perseguindo o jogador)
estado_passeando = function() // inimigo andando
{
    sprite = spRainha;

    // Define o destino do rei como a posição do jogador
    destino_x = oPlayer.x;
    destino_y = oPlayer.y;

    // Calcula a direção em direção ao destino (jogador)
    var _dir = point_direction(x, y, destino_x, destino_y);
    
    // Move o rei na direção do destino
    var new_x = x + lengthdir_x(vel, _dir);
    var new_y = y + lengthdir_y(vel, _dir);
    
    // Verificar se a nova posição está dentro dos limites da room
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

    // Verificar colisão com oblock
    if (!place_meeting(new_x, new_y, oBlock)) {
        // Atualizar a posição do rei se não houver colisão
        x = new_x;
        y = new_y;
    }
    
    show_debug_message("REI PERSEGUINDO");
    muda_estado([estado_parado, estado_passeando]);
}

// Define o estado inicial do rei
estado = estado_parado;
