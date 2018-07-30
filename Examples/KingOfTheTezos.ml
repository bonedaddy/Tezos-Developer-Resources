[%%version 0.3]

(* because every blockchain needs a ponzi scheme, WIP *)
(* must be played from KT1 addresses as they are contract addresses *)

type storage = {
  owner : key_hash;
  user : key_hash;
  user_address : address;
  identifier : string;
  bid : tez;
  fee : tez;
}

let%entry main
  (parameter : key_hash)
  (storage : storage) = 
  
  let amount = Current.amount() in
  let user = parameter in
  let user_address = Contract.address() in
  if user_address = storage.user_address then
    let storage = storage.bid <- storage.bid + amount in
    ( ([] : operation list), storage)
  else
    let storage = storage.user <- user in
    let storage = storage.user_address <- user_address in
    let bid_minus_fee = storage.bid - storage.fee in 
    let storage = storage.bid <- bid_minus_fee in
    ( ([] : operation list), storage)