class_name AutoloadMouse
extends Node
var user_toggle = true : set = set_user_toggle
var game_toggle = false : set = set_game_toggle
var window_toggle = true : set = set_window_toggle
var sensitivity = 0.3 * 5
var motion = Vector2.ZERO
var motion_previous = Vector2.ZERO
var user_toggle_action = "ui_cancel"
var caller
var callback

func _process(_delta):
	if user_toggle_action != "" \
	&& Input.is_action_just_pressed(user_toggle_action):
		set_user_toggle(!user_toggle)
	if motion == motion_previous: 
		motion = Vector2.ZERO
	motion_previous = motion
	if is_instance_valid(caller):
		caller.call(callback, motion, _delta)

func _notification(what):
	match what:
		MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
			set_window_toggle(false)
		MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
			set_window_toggle(true)

func _input(event):
	if event is InputEventMouseButton:
		if not user_toggle and game_toggle:
			set_user_toggle(true)
	
	elif game_toggle and user_toggle:
		if event is InputEventMouseMotion:
			if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
				motion = event.relative * sensitivity

func set_user_toggle(tog):
	user_toggle = tog
	if tog and game_toggle and window_toggle:
		capture_mouse()
	else:
		show_mouse()

func set_window_toggle(win):
	window_toggle = win
	if win and user_toggle and game_toggle:
		capture_mouse()
	else:
		show_mouse()

func set_game_toggle(cap):
	game_toggle = cap
	if cap and user_toggle and window_toggle:
			capture_mouse()
	else:
		show_mouse()
	
func get_motion():
	return motion

func capture_mouse():
	if get_viewport() != null:
		get_viewport().warp_mouse(get_viewport().get_size()*.5)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		call_deferred("capture_mouse")

func show_mouse():
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
