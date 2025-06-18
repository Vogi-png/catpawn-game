// colisão horizontal e movimentação
var _velh = sign(hveloc); //1, -1 ou 0

repeat(abs(hveloc))
{
	if (place_meeting(x + _velh, y, oBlock))
	{ // o que fazer se colidir com algo
		hveloc = 0;
	}
	else 
	{
		x += _velh;
	}
}


// colisão vertical e movimentação
var _velv = sign(vveloc); //1, -1 ou 0

repeat(abs(vveloc))
{
	if (place_meeting(x, y + _velv, oBlock))
	{ // o que fazer se colidir com algo
		vveloc = 0;
	}
	else 
	{
		y += _velv;
	}
}