[%%version 0.3]

type multi = {
  s1 : string;
  s2 : string;
}
let%entry main
    (parameter: string)
    (storage : multi) =

  let storage = storage.s1 <- "hello" in
  let storage = storage.s2 <- parameter in
  ( ([] : operation list), storage)
