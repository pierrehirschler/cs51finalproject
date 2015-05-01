open Str
open Event
open WorldObject
open WorldObjectI
  
(* populates the board *)

let part1_initializer () = 
  
  (* initiates the variable that will define the probability of a cell 
     being alive *)
  let social_probability : int ref = ref 14  in 

  print_string(string_of_int(!social_probability));
  
  let new_website = Sys.argv.(2) in
  
  let fa = Helpers.website_counter new_website  "facebook" in
  let tw = Helpers.website_counter new_website "twitter" in 
  let tu = Helpers.website_counter new_website "tumblr" in
  let insta = Helpers.website_counter new_website "instagram" in
  let hastag = Helpers.website_counter new_website "hashtag" in
  let tags = Helpers.website_counter new_website "tags" in
  let search = Helpers.website_counter new_website "search" in
  
  let sum_site : int ref = ref (fa + tw + tu + insta) in
  let sum_tag : int ref = ref (hastag + tags + search) in 
  
  let site_counter : int ref = ref 0 in 
 
  let random () =  while !site_counter <= 100 do 
      if !sum_site > !site_counter then 
	  social_probability := !social_probability - 1
      else  social_probability := !social_probability + 0; 
    site_counter := !site_counter + 15;
    done  in
  
  random (); 
  
  print_string(string_of_int(!social_probability));
  if !social_probability <= 2 then social_probability := 3 ;   

  if (!social_probability mod 2 == 0) &&  (!sum_tag >= ((!sum_site + 1) / 2)) 
  then social_probability := (!social_probability / 2) ; 
  if (!social_probability mod 2 == 1)  &&  (!sum_tag >= ((!sum_site + 1) / 2)) then
     social_probability := ((!social_probability + 1) / 2) ; 
  
  print_string(string_of_int(!sum_site));
  print_string(string_of_int(!sum_tag)); 
  print_string(string_of_int(!social_probability)); 
        
    for x = 0 to World.size -1 do
      for y = 0 to World.size -1 do
	ignore (new Alive.alive (x,y));
	match World.get (x,y) with
	|a::b -> Helpers.with_inv_probability World.rand !social_probability  
          (fun () -> a#switch_status; flush_all();)
	|_ -> ()
      done 
    done
(* print_string (string_of_int(y)); *)   
(* set_alive *)
	
(* Function that is called continuously while the simulation is running. *)
let event_loop part () : unit =
  Graphics.clear_graph () ;
  if part >= 2 then
    Event.fire_event World.action_event ();
    Event.fire_event World.switch_event ();
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
  let usage () = (Printf.printf "usage: %s argument\n" Sys.argv.(0); exit 1) in
  if Array.length Sys.argv <> 3 then usage ();
  (*let standard =  Str.regexp " ^[a-zA-Z0-9-.]+.(com|org|net|mil|edu|COM|ORG|NET|MIL|EDU)$"  match Sys.argv(2) with
  let webhistory = Sys.argv(2);*)
 (* if Not_found <> Str.search_forward standard Sys.argv.(2) 0 then *)
  match Sys.argv.(1) with 
  |"part2" -> part1_initializer, 2
  | _ -> usage ()

let run () : unit =
  let initialize, part = parse_args () in
  UI.run_world initialize (event_loop part)
;;

run () ;;
