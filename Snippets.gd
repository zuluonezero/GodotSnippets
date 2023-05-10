### None of this is mine - most of it comes from the Godot Tutorials - this is just my handy shortcut and memory jogger. :)
# A file is a class!

# Inheritance

extends BaseClass

# (optional) class definition with a custom icon

class_name MyClass, "res://path/to/optional/icon.svg"


# Member variables

var a = 5
var s = "Hello"
var arr = [1, 2, 3]
var dict = {"key": "value", 2: 3}
var typed_var: int
var inferred_type := "String"

# Constants

const ANSWER = 42
const THE_NAME = "Charly"

# Enums

enum {UNIT_NEUTRAL, UNIT_ENEMY, UNIT_ALLY}
enum Named {THING_1, THING_2, ANOTHER_THING = -1}

# Built-in vector types

var v2 = Vector2(1, 2)
var v3 = Vector3(1, 2, 3)


# Function

func some_function(param1, param2):
    var local_var = 5

    if param1 < local_var:
        print(param1)
    elif param2 > 5:
        print(param2)
    else:
        print("Fail!")

    for i in range(20):
        print(i)

    while param2 != 0:
        param2 -= 1

    var local_var2 = param1 + 3
    return local_var2


# Functions override functions with the same name on the base/parent class.
# If you still want to call them, use '.' (like 'super' in other languages).

func something(p1, p2):
    .something(p1, p2)


# Inner class

class Something:
    var a = 10


# Constructor

func _init():
    print("Constructed!")
    var lv = Something.new()
    print(lv.a)


# Export
@export var mob_scene: PackedScene

# Get Screen Size
screen_size = get_viewport_rect().size

# Player movement
    var velocity = Vector2.ZERO # The player's movement vector.
    if Input.is_action_pressed("move_right"):
        velocity.x += 1

    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        $AnimatedSprite2D.play()
    else:
        $AnimatedSprite2D.stop()		

position += velocity * delta
position.x = clamp(position.x, 0, screen_size.x)
position.y = clamp(position.y, 0, screen_size.y)

$AnimatedSprite2D.flip_h = velocity.x < 0
$AnimatedSprite2D.flip_v = velocity.y > 0

# Hide and Make Visible in the Game
hide()
show()

# Signals
signal hit
hit.emit()

# Collisions
$CollisionShape2D.disabled = false

# Animation
var mob_types = $AnimatedSprite2D.get_sprite_frames().get_animation_names()
    $AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]

# Random
You must use randomize() if you want your sequence of "random" numbers to be different every time you run the scene.

# On Visible
-: Connect the screen_exited() signal of the VisibleOnScreenNotifier2D
func _on_visible_on_screen_notifier_2d_screen_exited():
    queue_free()

# Timers
$ScoreTimer.stop()
$Player.start($StartPosition.position)

func _on_ScoreTimer_timeout():
    score += 1

func _on_StartTimer_timeout():
    $MobTimer.start()
    $ScoreTimer.start()

signal start_game

    $Message.text = text
    $Message.show()

    show_message("Game Over")
    # Wait until the MessageTimer has counted down.
    await $MessageTimer.timeout

    $Message.show()
    # Make a one-shot timer and wait for it to finish.
    await get_tree().create_timer(1.0).timeout

$ScoreLabel.text = str(score)

# Buttons

func _on_StartButton_pressed():
    $StartButton.hide()
    start_game.emit()

# Reference other Scenes
$HUD.update_score(score)

# Work with the Tree
get_tree().call_group("mobs", "queue_free")

# Play Music
$Music.play()

----------- Mob spawning -----------------
func _on_MobTimer_timeout():
    # Create a new instance of the Mob scene.
    var mob = mob_scene.instantiate()

    # Choose a random location on Path2D.
    var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
    mob_spawn_location.progress_ratio = randi()

    # Set the mob's direction perpendicular to the path direction.
    var direction = mob_spawn_location.rotation + PI / 2

    # Set the mob's position to a random location.
    mob.position = mob_spawn_location.position

    # Add some randomness to the direction.
    direction += randf_range(-PI / 4, PI / 4)
    mob.rotation = direction

    # Choose the velocity for the mob.
    var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
    mob.linear_velocity = velocity.rotated(direction)

    # Spawn the mob by adding it to the Main scene.
    add_child(mob)
-----------------------------------------------

# Groups

The method is_in_group() is available on every Node.
