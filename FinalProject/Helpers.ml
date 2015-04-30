(** A package of generic and useful helper functions. *)
exception TODO


(*************************)
(***** Array Helpers *****)
(*************************)

(** Modify each element of an array in place *)
let array_map_modify (f:'a -> 'a) (arr:'a array) : unit =
  Array.iteri (fun i _ -> arr.(i) <- f (arr.(i))) arr

(************************)
(***** List Helpers *****)
(************************)

(** The list containing n replicas of e *)
let rec replicate (n:int) (e:'a) : 'a list =
  if n = 0 then [] else e::replicate (n-1) e

(** The cross produce of lists xs and ys.
    result = \[ (x,y) | x in xs and y in ys \] *)
let rec cross (xs:'a list) (ys:'b list) : ('a*'b) list =
  match xs with
  | [] -> []
  | hd::tl -> List.map (fun y -> (hd,y)) ys @ cross tl ys

(** The monotonically increasing list containing each number in the range
    between n1 and n2 (inclusive) *)
let rec range (n1:int) (n2:int) : int list =
  if n1 > n2 then [] else n1::range (n1+1) n2

(** The list of unique elements in xs. *)
let rec unique xs =
  match xs with
  | [] -> []
  | hd::tl ->
      let tl' = unique tl in
      if List.mem hd tl' then tl' else hd::tl'

(**************************)
(***** Number Helpers *****)
(**************************)

(** Bound x between low and high. *)
let bound (low:int) (high:int) (x:int) : int = min (max low x) high

(********************************)
(***** Random Value Helpers *****)
(********************************)

(** call f with probability (1/p) and g if f is not called *)
let with_inv_probability_or (r:int->int) (p:int)
                            (f:unit->'a) (g:unit->'a) : 'a =
  if r p = 0 then f () else g ()

(** Call f with probability (1/p) (using r to generate random numbers) *)
let with_inv_probability (r:int->int) (p:int) (f:unit->unit) : unit =
  with_inv_probability_or r p f (fun () -> ())

(** Call one of the functions in the list with equal probability. *)
let with_equal_probability (r:int->int) (fs:(unit -> unit) list) : unit =
  (List.nth fs (r (List.length fs))) ()


let website_counter (url: string) (website:string): int =
    let website_length = String.length website in
    let regular_website = Str.regexp website in
    let length_difference = (String.length url) - website_length in
     (*  and regular_website = Str.regexp_string website in *)  
    let rec helper_counter position counter =
    if position > length_difference then counter else
      try
        let new_position = Str.search_forward regular_website  url position in
        helper_counter (new_position + website_length) (counter+1)
      with Not_found -> counter
    in
    helper_counter 0 0 

(*
let social_probability (url: string array -> int -> string) (website:string): int = 
  let website_length = String.length website in
  let regular_website = Str.regexp website in
  let length_difference = (String.length url) - website_length in
     (*  and regular_website = Str.regexp_string website in *)  
  let rec helper_counter position counter =
    if position > length_difference then counter else
      try
        let new_position = Str.search_forward regular_website  url position in
        helper_counter (new_position + website_length) (counter+1)
      with Not_found -> counter
    in
    helper_counter 0 0 *)
