open Event
  
(* populates the board *)

let set_alive () =
for c = 0 to 1 do
let x = Random.int World.size in
let y = Random.int World.size in
match World.get (x,y) with
|a::b -> Helpers.with_inv_probability World.rand 5 
(fun () -> a#switch_status; print_string (string_of_int(x));
print_string (string_of_int(y)); flush_all();)
|_ -> ()
done
  
let part1_initializer () =
for x = 0 to World.size -1 do
for y = 0 to World.size -1 do
 ignore (new Alive.alive (x,y));
 set_alive();
done
done

(* set_alive *)
	
(* Function that is called continuously while the simulation is running. *)
let event_loop part () : unit =
  Graphics.clear_graph () ;
  if part >= 2 then Event.fire_event World.action_event () ;
  (* draw loop *)
  begin
  for x = 0 to World.size -1 do
    for y = 0 to World.size -1 do
      List.iter (fun w -> w#drawalive) 
      (List.filter (fun x -> x#get_status = "alive") (World.get (x,y)))
    done
  done
  end


(* Parse command-line arguments. Returns the appropriate initialization
   function to run and the current part. *)
let parse_args () : (unit -> unit) * int =
  let usage () = Printf.printf "usage: %s argument\n" Sys.argv.(0); exit 1 in
  if Array.length Sys.argv <> 2 then usage ();
  match Sys.argv.(1) with
  | "part2" -> part1_initializer, 2
  | _ -> usage ()
    
    
let run () : unit =
  let initialize, part = parse_args () in
  UI.run_world initialize (event_loop part)
;;

run () ;;
