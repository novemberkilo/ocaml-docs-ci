open Capnp_rpc_lwt

module Build_status : sig
  type t = Raw.Reader.BuildStatus.t

  val pp : t Fmt.t
end

module State : sig
  type t = Raw.Reader.JobInfo.State.unnamed_union_t

  val pp : t Fmt.t
  val from_build_status : [< `Failed | `Not_started | `Passed | `Pending ] -> t
end

module Project : sig
  type t = Raw.Client.Project.t Capability.t

  type project_version = {
      version: string;
    }

  val versions : t -> unit -> (project_version list, [> `Capnp of Capnp_rpc.Error.t]) Lwt_result.t
end

module Pipeline : sig
  type t = Raw.Client.Pipeline.t Capability.t
  (** The top level object for ocaml-docs-ci. *)

  val project : t -> string -> Raw.Reader.Project.t Capability.t

  val projects : t -> (Raw.Reader.ProjectInfo.t list, [> `Capnp of Capnp_rpc.Error.t]) Lwt_result.t

end