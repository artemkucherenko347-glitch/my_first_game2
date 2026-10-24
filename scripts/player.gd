class_name Player # Реєструємо глобальний клас Player для перевірки через body is Player.

extends CharacterBody2D # Успадковуємо фізичну поведінку 2D-персонажа.

const SPEED := 300.0 # Задаємо швидкість руху по горизонталі.

const JUMP_VELOCITY := -400.0 # Задаємо силу стрибка; мінус означає рух угору.

func _physics_process(delta: float) -> void: # Виконуємо фізичну логіку кожен фізичний кадр.

    if not is_on_floor(): # Перевіряємо, чи гравець не стоїть на поверхні.

        velocity += get_gravity() * delta # Додаємо гравітацію з урахуванням часу кадру.

    if Input.is_action_just_pressed("jump") and is_on_floor(): # Дозволяємо стрибок лише із землі.

        velocity.y = JUMP_VELOCITY # Задаємо вертикальну швидкість стрибка.

    var direction := Input.get_axis("move_left", "move_right") # Отримуємо напрямок із Input Map.

    if direction != 0.0: # Перевіряємо, чи натиснута клавіша руху.

        velocity.x = direction * SPEED # Рухаємось ліворуч або праворуч.

    else: # Якщо клавіші руху не натиснуті.

        velocity.x = move_toward(velocity.x, 0.0, SPEED) # Плавно зупиняємо гравця.

    move_and_slide() # Переміщуємо тіло з урахуванням колізій.

