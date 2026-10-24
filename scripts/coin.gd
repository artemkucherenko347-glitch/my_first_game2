extends Area2D # Монета є зоною, яка виявляє входження фізичного тіла.

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D # Отримуємо вузол анімації.

@onready var collision_shape: CollisionShape2D = $CollisionShape2D # Отримуємо форму зіткнення.

var collected := false # Забороняємо повторний збір монети.

func _ready() -> void: # Виконуємо початкове налаштування.

    body_entered.connect(_on_body_entered) # Підключаємо сигнал входження тіла.

    if animated_sprite.sprite_frames and animated_sprite.sprite_frames.has_animation("spin"): # Перевіряємо анімацію обертання.

        animated_sprite.play("spin") # Запускаємо обертання монети.

func _on_body_entered(body: Node2D) -> void: # Обробляємо тіло, яке увійшло в зону.

    if not body is Player or collected: # Реагуємо лише на Player і лише один раз.

        return # Завершуємо обробник для інших тіл.

    collected = true # Фіксуємо, що монета зібрана.

    collision_shape.set_deferred("disabled", true) # Вимикаємо колізію безпечно.

    if animated_sprite.sprite_frames and animated_sprite.sprite_frames.has_animation("collect"): # Перевіряємо анімацію збору.

        animated_sprite.play("collect") # Запускаємо анімацію збору.

        await animated_sprite.animation_finished # Очікуємо завершення анімації.

    queue_free() # Видаляємо монету зі сцени.

