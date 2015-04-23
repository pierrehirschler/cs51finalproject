open Event
open Command.Spec
open Str 
  
(* populates the board *)
(* 
let set_alive () =
for c = 0 to 1 do
let x = Random.int World.size in
let y = Random.int World.size in
match World.get (x,y) with
|a::b -> Helpers.with_inv_probability World.rand 5 
(fun () -> a#switch_status; print_string (string_of_int(x));
print_string (string_of_int(y)); flush_all();)
|_ -> ()
done *)
  
let part1_initializer () =
  let count_substring str sub =
    let sub_len = String.length sub in
    let len_diff = (String.length str) - sub_len
    and reg = Str.regexp_string sub in
  
    let rec aux i n =
    if i > len_diff then n else
      try
        let pos = Str.search_forward reg str i in
        aux (pos + sub_len) (succ n)
      with Not_found -> n
    in
    aux 0 0 ; 

    let social_probability = 0 ref in

    let fa = count_substring webhistory "facebook" in
    let tw = count_substring webhistory "twitter" in
    let tu = count_substring webhistory "tumblr" in
    let insta = count_substring webhistory "instagram" in

  if (fa > tw && fa > insta && fa > tu) then social_probability := 100 
  else if (tw > fa && tw > insta && tw > tu) then social_probability := 50
  else if (tu > tw && tu > insta && tu > fa) then social_probability := 20
  else if (insta > tw && insta > fa && insta > tu) then social_probability := 70; 

  for x = 0 to World.size -1 do
    for y = 0 to World.size -1 do
      ignore (new Alive.alive (x,y));
      match World.get (x,y) with
      |a::b -> Helpers.with_inv_probability World.rand !social_probability  
        (fun () -> a#switch_status; print_string (string_of_int(x));
        print_string (string_of_int(y)); flush_all();)
      |_ -> ()
    done
  done
in


(* set_alive *)
	
(* Function that is called continuously while the simulation is running. *)
let event_loop part () : unit =
  Graphics.clear_graph () ;
  if part >= 2 then Event.fire_event World.action_event () ;print_string ("fired"); flush_all();
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
let parse_args () : (unit -> unit)=
  let usage () = Printf.printf "usage: %s argument\n" Sys.argv.(0); exit 1 in
  if Array.length Sys.argv <> 3 then usage ();
  Sys.argv(2) <- webhistory
  match Sys.argv.(2) with
  | if Not_found <> Str.search_forward Str.regexp "^[a-zA-Z0-9\-\.]+\.(com|org|net|mil|edu|COM|ORG|NET|MIL|EDU)$" "webhistory" 0
    match Sys.argv.(1) with "part2" -> part1_initializer
  | _ -> usage ()

    
let run () : unit =
  let initialize, part = parse_args () in
  UI.run_world initialize (event_loop part)
;;

run () ;;
