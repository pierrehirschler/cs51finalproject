open WorldObject
open WorldObjectI

class dead p : world_object_i = 
object (self)
inherit world_object p as super

initializer (self#register_handler World.action_event self#check_neighbor)

method private check_neighbor = 
let len = List.length (List.filter (fun x -> x#get_name = "alive") 
(World.objects_within_range self#get_pos 1)) in 
if (len > 2 || 3 > len) then (new Alive.alive self#get_pos; self#die)
else ()

method get_name = "dead"
end
