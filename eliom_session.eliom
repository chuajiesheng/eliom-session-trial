{shared{
  open Eliom_lib
  open Eliom_content
}}

module Eliom_session_app =
  Eliom_registration.App (
    struct
      let application_name = "eliom_session"
    end)

let main_service =
  Eliom_service.service ~path:[] ~get_params:Eliom_parameter.unit ()

let external_method ~p1 ~p2 () =
  let _ = Session.check_person () in
  let p = "hello" in
  let _ = Session.set_person p in
  ()

let () =
  Eliom_session_app.register
    ~service:main_service
    (fun () () ->
     let _ = external_method ~p1:"p1" ~p2:"p2" () in
     Lwt.return
       (Eliom_tools.F.html
          ~title:"eliom_session"
          ~css:[["css";"eliom_session.css"]]
          Html5.F.(body [
                       h2 [pcdata "Welcome from Eliom's destillery!"];
    ])))
