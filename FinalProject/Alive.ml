open WorldObject
open WorldObjectI

class alive p: 
object
  inherit world_object_i
  method get_status : string
  method switch_status : unit
  method get_gen: int
end =
object (self)
    inherit world_object p as super

val mutable name = "dead"
val mutable gen = 0

initializer (self#register_handler World.action_event self#check_neighbor)

method private check_neighbor () = 
if gen = 0 then () else
print_string ("checked"); flush_all();
let len = List.length (List.filter (fun x -> x#get_status = "alive") 
(World.objects_within_range self#get_pos 1)) in 
match name with
|"alive" -> ( if len < 2 || len > 3 then name <- "dead"; gen <- gen + 1)
|"dead" -> ( if len = 3 then name <- "alive";  gen <- gen + 1)

method get_status = name
method get_gen = gen
method switch_status =  if name = "dead" then name <- "alive" else name <- "dead"
method private drawalive = self#draw_circle Graphics.black  Graphics.white " "; 
method draw_z_axis = 0
end
