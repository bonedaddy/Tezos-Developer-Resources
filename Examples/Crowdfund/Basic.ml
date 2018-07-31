[%%version 0.3]

  (* Basic Tezos crowdfunding contract *)
  (* Author - Postables *)

type storage = {
  owner : key_hash;
  funding_goal : tez;
  amount_raised : tez;
  soft_cap : tez;
}

let%init storage = {
  owner = tz1YLtLqD1fWHthSVHPD116oYvsd4PTAHUoc;
  funding_goal = 100tz;
  amount_raised = 0tz;
  soft_cap  = 75tz;
}

let%entry main 
    (parameter : key_hash)
    (storage : storage) =
  
  if storage.amount_raised >= storage.funding_goal then 
    if (Current.amount()) > 0tz then
      Current.failwith "funding goal already reached"
    else
      let owner_typed = Account.default storage.owner in
      let owner_refund_op = Contract.call owner_typed storage.funding_goal () in
      ( [owner_refund_op], storage)
  else 
    let amount = Current.amount() in
    let new_raise = amount + storage.amount_raised in
    if new_raise > storage.funding_goal then
      let difference = new_raise - storage.funding_goal in
      let key_typed = Account.default parameter in
      let sender_refund_op = Contract.call key_typed difference () in
      ( [sender_refund_op], storage)
    else
      let storage = storage.amount_raised <- amount in
      ( ([] : operation list), storage)
