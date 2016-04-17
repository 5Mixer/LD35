package;

import luxe.Color;
import luxe.Component;
import luxe.Sprite;

/**
 * This will set the color of any Sprite to a gradient.
 *
 * @author Abel Toy
 * @license The MIT License (https://gist.github.com/Rolpege/6e28392bc0bec79876d5#file-license)
 * LD Usage: I kind of consider this to be a lib. If you have issues, tell your pets. Or me. *shrug*
 */
enum GradientDirection
{
	Vertical;
	Horizontal;
}

class Gradient extends Component
{
	public var colorA(get, set):Color;
	public var colorB(get, set):Color;

	public var direction(get, set):GradientDirection;

	var _sprite:Sprite;

	var _colorA:Color;
	var _colorB:Color;

	var _direction:GradientDirection = Vertical;

	public function new(colorA:Color, colorB:Color, ?direction:GradientDirection)
	{
		super({ name: "gradient" });

		_colorA = colorA;
		_colorB = colorB;

		if (direction == null) direction = Vertical;
		_direction = direction;
	}

	override public function init()
	{
		_sprite = cast entity;

		_updateColors();
	}

	function _updateColors():Void
	{
		if (_sprite == null) return;

		if(_direction == Vertical)
		{
			_sprite.geometry.vertices[0].color = _colorA;
			_sprite.geometry.vertices[1].color = _colorA;
			_sprite.geometry.vertices[4].color = _colorA;

			_sprite.geometry.vertices[2].color = _colorB;
			_sprite.geometry.vertices[3].color = _colorB;
			_sprite.geometry.vertices[5].color = _colorB;
		}
		else
		{
			_sprite.geometry.vertices[0].color = _colorA;
			_sprite.geometry.vertices[3].color = _colorA;
			_sprite.geometry.vertices[4].color = _colorA;

			_sprite.geometry.vertices[1].color = _colorB;
			_sprite.geometry.vertices[2].color = _colorB;
			_sprite.geometry.vertices[5].color = _colorB;
		}
	}

	function get_colorA():Color
	{
		return _colorA;
	}

	function set_colorA(value:Color):Color
	{
		_colorA = value;
		_updateColors();
		return value;
	}

	function get_colorB():Color
	{
		return _colorB;
	}

	function set_colorB(value:Color):Color
	{
		_colorB = value;
		_updateColors();
		return value;
	}

	function get_direction():GradientDirection
	{
		return _direction;
	}

	function set_direction(value:GradientDirection):GradientDirection
	{
		if (value == _direction) return value;

		_direction = value;
		_updateColors();
		return value;
	}
}
