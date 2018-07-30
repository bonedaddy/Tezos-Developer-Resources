[%%version 0.3]

let%entry main
  (parameter : string)
  (storage : string) =

  let storage = parameter in 
  ( ([] : operation list), storage)
