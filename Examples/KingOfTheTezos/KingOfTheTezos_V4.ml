[%%version 0.3]

(* KingOfTheTezos - Tezos version of King Of The Ether *)
(* Author - Postables *)
(* Version - 0.4 *)
(*
  //INTRODUCTION//

  The greetings and passings tributes are fixed. The idea behind this is that as time goes on, and tezos becomes more popular;
  it becomes more costly to usurp, which will have the side effect that as time goes on, and if tezos price keeps increasing being
  the current king, or even a king in the past, becomes a rarity so that only the most bravest of foes will dare usurp kings years from now.

  //INSTRUCTIONS//
  In order to usurp the previous king, you must pay more than their throne is worth, while still paying tribute to the creator (Postables! :D).
  You can increase your throne's warchest after claiming it as much as you want now that you have the creators blessing. With the creators blessing you can increase your war chest as much as you want, without paying additional tribute.

  Should you be usurped, before you have had the chance to supply your warchest, you receive nothing, and swept aside along with the rest of the fools who tried to seek victory. If however you managed to supply your war chest, you will be given riches beyond your wildest imaginations.

  TL;DR non "rp" rules:
    1) Pay a higher tezos amount that the current throne. This must be greater than the current throne plus the greetings and passings tribute.
    2) Attempt to supply your war chest after claiming the throne.
    3) If you manage to supply your warchest before you are usurped, you will be rewarded, equivalent to the war chest size.

    *Initial throne refers to the amount required to usurp the previous king
    *Warchest size is calculated by the difference of the current throne and your initial throne.
*)

type storage = {
  creator : key_hash;
  king : key_hash;
  king_address : address;
  initial_throne : tez;
  throne : tez;
  greetings_tribute : tez;
  passings_tribute :   tez;
  players : (key_hash, tez) map;
}

(* This is used to initialize our storage *)
let%init storage 
    (creator_key              : key_hash)
    (your_key                 : key_hash)
    (greetings_tribute_amount : tez)
    (passings_tribute_amount  : tez)  = {
  creator = creator_key;
  greetings_tribute = greetings_tribute_amount;
  passings_tribute = passings_tribute_amount;
  king = your_key;
  king_address = Current.source();
  initial_throne = Current.amount();
  throne = Current.amount();
  players = Map.add creator_key (Current.amount()) (Map [tz1Wpefz7KdEkVf2hXGMRKYymVjML9Zpi1r7, 0tz]);
}

(* This is where all user interaction occurs *)
let%entry main
    (parameter : key_hash) 
    (storage : storage) = 
  
  (* get the parameter *)
  let king = parameter in
  (* get the address of the current transaction *)
  let king_address = Current.source() in
  (* If they are the current king, update their throne, 
  otherwise attempt to overtake throne *)
  if king_address = storage.king_address then
    let throne_power_up = Current.amount() in
    let new_throne = storage.throne + throne_power_up in
    let storage = storage.players <- Map.add king new_throne storage.players in
    let storage = storage.throne <- new_throne in
    ( ([] : operation list), storage)
  else
    (* Get the current throne bid *)
    let throne_bid = Current.amount() in
    (* Calculate remaining bid after tribute *)
    let throne_bid_minus_tributes = (throne_bid - storage.greetings_tribute) - storage.passings_tribute in
    (* Check if they have enough to usurp after removing all tributes*)
    if throne_bid_minus_tributes <= storage.throne then
      Current.failwith "pitiful attempt to overthrow the throne. pay more"
    else
      (*calculate war chest**)
      let war_chest = storage.throne - storage.initial_throne in
      (* update initial throne *)
      let storage = storage.initial_throne <- throne_bid_minus_tributes in
      (* update players *)
      let storage = storage.players <- Map.add king throne_bid_minus_tributes storage.players in 
      (* create the creator refund *)
      let creator_refund_amount = storage.passings_tribute + storage.greetings_tribute in
      (* created a sendable address for creator *)
      let creator_typed = Account.default storage.creator in
      (* create refund operation for creator *)
      let creator_refund_op = Contract.call creator_typed creator_refund_amount () in
      (* get old king *)
      let old_king = storage.king in
      (* update storage with new king *)
      let storage = storage.king <- king in
      (* update storage with new king address *)
      let storage = storage.king_address <- king_address in
      (* check to see if old king has a warchest*)
      if war_chest > 0tz then
        (* create sendable address for old king *)
        let old_king_typed = Account.default old_king in
        (* create refund opeartion for old king *)
        let old_king_refund_op = Contract.call old_king_typed war_chest () in
        (* processes operations, update storage*)
        ( [creator_refund_op; old_king_refund_op], storage)
      else
        (* we only need to pay the creator *)
        ( [creator_refund_op], storage)
      
      