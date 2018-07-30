[%%version 0.3]

let%entry main
  (parameter : string)
  (storage : string) = 

  (* <> is the NOT EQUAL operator *)

  if parameter <> "hello world" then
    Current.failwith "parameter must be 'hello world'"
  else
    let storage = parameter in
    ( ([] : operation list), storage)