[%%version 0.3]

(* KingOfTheTezos - Tezos version of King Of The Ether *)
(* Author - Postables *)
(* Version - 0.1 *)
(* Must be played from kt1 addresses *)

type storage = {
  owner : key_hash;
  king : key_hash;
  king_address : address;
  throne : tez;
  fee : tez;
}

(* This is used to initialize our storage *)
let%init storage (owner_key : key_hash) (fee_amount : tez)  = {
  owner = owner_key;
  fee = fee_amount;
  king = owner_key;
  king_address = Current.source();
  throne = Current.amount();
}

(* This is where all user interaction occurs *)
let%entry main
    (parameter : key_hash) 
    (storage : storage) = 
  
  (* Get current amount of transaction *)
  let throne = Current.amount() in
  (* set the passed in parameter in variable king *)
  let king = parameter in
  (* get the address of the current transaction *)
  let king_address = Current.source() in
  (* If they are the current king, update their throne, 
  otherwise attempt to overtake throne *)
  if king_address = storage.king_address then
    let storage = storage.throne <- storage.throne + throne in
    ( ([] : operation list), storage)
  else
    (* Calculate throne size after paying tribute *)
    let throne_minus_fee = throne - storage.fee in
    (* make sure they have a big enough throne, otherwise fail *)
    if throne_minus_fee < storage.throne then
      Current.failwith "throne too small after paying tribute"
    else 
      (* Update current king key hash *)
      let storage = storage.king <- king in
      (* Update current king address *)
      let storage = storage.king_address <- king_address in
      (* Update throne size *)
      let storage = storage.throne <- throne_minus_fee in
      (* Create sendable address from owner *)
      let owner = Account.default storage.owner in
      (* Send tribute to owner *)
      let op = Contract.call owner storage.fee () in
      ( [op], storage)