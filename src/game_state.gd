extends Node


var request_done: bool = false
var flower_status: bool = false
var flower_has: bool = false
var axe_has: bool = false
var flower_gave: String = ""
var snake_status: String = ""
var repellant_status: String = ""
var is_carrying_repellant: bool = false
var loud_noise_heard: bool = false


#horse quest stats

#if the old man has requested.
var has_requested: bool = false


var interacting_object: Area2D

signal repellant_status_changed(object, status, is_carrying)

