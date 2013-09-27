let _person =
  Eliom_reference.eref
    ~scope:Eliom_common.default_session_scope None

let get_person () =
  lwt session = Eliom_reference.get _person in
  let _ = match session with
    | Some(p) -> Debug.info "[get_person] retrieve session %s" p
    | None -> Debug.info "[get_person] retrieve no session" in
  Eliom_reference.get _person

let get_person_safe () =
  try
    let p = get_person () in
    p
  with _ ->
    let _ = Debug.info "[get_person_safe] exception" in
    Lwt.return None

let check_person () =
  let _ = Debug.info "[check_person] checking person" in
  get_person_safe ()

let set_person (p : string) =
  lwt s = get_person_safe () in
  let _ = match s with
    | Some(p) -> Debug.info "[set_person] existed"
    | None -> Debug.info "[set_person] none" in
  let _ = Debug.info "[set_person] %s session started" p in
  let _ = Eliom_reference.set _person (Some (p)) in
  check_person ()
