[%%version 0.3]

type multi = {
  s1 : string;
  s2 : string;
  value : tez;
}

let%entry main
    (parameter : string)
    (storage : multi) =

  let amount = Current.amount() in
  if amount < 10.00tz then
    Current.failwith "need to pay 10tz"
  else
    let storage = storage.s1 <- "hello" in
    let storage = storage.s2 <- parameter in
    let storage = storage.value <- amount in
    ( ([] : operation list), storage)