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
  let king = parameter in
  let king_address = Current.source() in
  if king_address = storage.king_address then
    let storage = storage.throne <- storage.throne + throne in
    ( ([] : operation list), storage)
  else
    let storage = storage.king <- king in
    let storage = storage.king_address <- king_address in
    let throne_minus_fee = throne - storage.fee in
    let storage = storage.throne <- throne_minus_fee in
    let owner = Account.default storage.owner in
    let op = Contract.call owner storage.fee () in
    ( [op], storage)