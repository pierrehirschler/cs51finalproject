open WorldObject
open WorldObjectI

class type alive_i =
object
  inherit world_object_i
  method get_status : string
  method switch_status : unit
  method get_gen: int
end

class alive p: alive_i =  
object (self)
    inherit world_object p as super

val mutable name = "dead"
val mutable gen = 0
val mutable len = 0

initializer (self#register_handler World.action_event self#check_neighbor)
initializer (self#register_handler World.switch_event self#switch)

method private check_neighbor () = 
if gen = 0 then () else
print_string ("checked"); flush_all();
len <- (List.length (List.filter (fun x -> x#get_status = "alive") 
(World.objects_within_range self#get_pos 1)));

method private switch () =
match name with
|"alive" -> ( if len -1 < 2 || len - 1 > 3 then name <- "dead"; gen <- gen + 1)
|"dead" -> ( if len  = 3 then name <- "alive";  gen <- gen + 1)
| _ -> failwith "Invalid neighbor name"

method get_status = name
method get_gen = gen
method switch_status =  if name = "dead" then name <- "alive" else name <- "dead"
method private drawalive = self#draw_circle Graphics.black  Graphics.white " "; 
method draw_z_axis = 0
end
