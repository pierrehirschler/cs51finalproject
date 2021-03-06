open Event
open WorldObjectI

(** An abstract implementation of world_object_i that provides some helper
    functionality.

    All world_object objects add themselves to the world at point initial_p upon
    creation. *)
class world_object (initial_p:int*int) : world_object_i =
object (self)

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  val die_event : unit Event.event = Event.new_event ()
  val danger_event : world_object_i Event.event = Event.new_event ()

  val mutable pos : int*int = initial_p

  (***********************)
  (***** Initializer *****)
  (***********************)

  initializer
    World.add pos (self :> world_object_i) ;

  (**************************)
  (***** Helper Methods *****)
  (**************************)

  method private set_pos (p:int*int) : unit =
    if World.can_move p then begin
      World.remove_must_exist pos (self :> world_object_i) ;
      World.add p (self :> world_object_i) ;
      pos <- p
    end else
      ()

  (*******************************)
  (***** WorldObject Methods *****)
  (*******************************)

  method private register_handler : 'a. 'a Event.event -> ('a -> unit) -> unit =
    fun e f ->
      let id = Event.add_listener e f in
      ignore(Event.add_listener die_event (fun () -> Event.remove_listener e id))

  method private move d =
    self#set_pos (Direction.move_point pos d)

  method private draw_circle bg fg text =
    Draw.circle pos World.obj_width World.obj_height bg fg text

  method private draw_status_bar c v =
    let h = World.obj_height / 10 in
    Draw.status_bar pos World.obj_width World.obj_height c h v

  method get_name = "object"

  method switch_status = ()
  
  method get_status = "wa"

  method get_pos = pos
  
  method get_gen = 0

  method drawalive = self#draw_circle Graphics.black Graphics.black "" 
 

  method draw_z_axis = 1

  method is_obstacle = false

  method smells_like_pollen = None

  method forfeit_pollen = None

  method receive_pollen ps = ps

  method receive_sting = ()

  method get_die_event = die_event

  method die =
    Event.fire_event die_event () ;
    World.remove_must_exist pos (self :> world_object_i)

  method get_danger_event = danger_event

  method danger o = Event.fire_event danger_event o


end

