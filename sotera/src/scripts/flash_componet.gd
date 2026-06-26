class_name FlashComponent
extends Node

@export var sprite_2d: CanvasItem
@export var flash_duration: float = 0.2
@export var num_of_flashes: int = 1

const Flash_Shader: Shader = preload("res://assets/materials/flash.gdshader")

var flash_material: ShaderMaterial

func _ready() -> void:
	flash_material = ShaderMaterial.new()
	flash_material.shader = Flash_Shader
	flash_material.resource_local_to_scene = true
	if sprite_2d:
		sprite_2d.material = flash_material
	else:
		print("eror there is no sprite")

func _flash() -> void:
	for i in range(num_of_flashes):
		flash_material.set_shader_parameter("flash_enable", true)
		await get_tree().create_timer(flash_duration).timeout
		if not is_instance_valid(flash_material):
			return

		flash_material.set_shader_parameter("flash_enable", false)
		await get_tree().create_timer(flash_duration).timeout
		if not is_instance_valid(flash_material):
			return
