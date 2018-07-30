[%%version 0.3]

let%entry main
    (parameter: string)
    (storage : string) =

  let amount = Current.amount() in

  if amount < 10.00tz then
    Current.failwith "Not enough money, costs 10tz to set"
  else
    let storage = parameter in 
    ( ([] : operation list), storage)