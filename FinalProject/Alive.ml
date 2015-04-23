open WorldObject
open WorldObjectI

class alive p : 
object
  inherit world_object_i
  method get_status : string
  method switch_status : unit
end =
object (self)
    inherit world_object p as super

val mutable name = "dead"

initializer (self#register_handler World.action_event self#check_neighbor)

method private check_neighbor = 
print_string ("checked"); flush_all();
let len = List.length (List.filter (fun x -> x#get_status = "alive") 
(World.objects_within_range self#get_pos 1)) in 
match name with
|"alive" -> (fun () -> if len < 2 || len > 3 then name <- "dead")
|"dead" -> (fun () -> if len = 3 then name <- "alive")

method get_status = name
method switch_status =  if name = "dead" then name <- "alive" else name <- "dead"
method private drawalive = self#draw_circle Graphics.black  Graphics.white " "; 
method draw_z_axis = 0
end
