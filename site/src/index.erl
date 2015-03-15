%% -*- mode: nitrogen -*-
%% vim: ts=4 sw=4 et
-module (index).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

main() -> #template { file="./site/templates/bare.html" }.

body() -> 
    [
        #panel { class="form-group", body = [
            #textbox { id=search, class="form-control", placeholder = "Населенный пункт" }
        ] },
        #button { class="btn", text = "Искать", actions=#event{type=click,postback=search} },
        #panel { id=result }
    ].

query_names(Name) ->
    db:equery("SELECT node_id, name FROM name WHERE name LIKE $1 ORDER BY name DESC", [Name]).

format_names(Names) ->
    [ #link { text=Name, url=io_lib:format("node/view/~B", [Id]) } || {Id, Name} <- Names ].

new_node(Name) -> [
    #panel { text=wf:f("Населённый пункт \"~ts\" не найден.", [Name]) },
    #link { text="Создать?", actions=#event{type=click,postback={create,Name}} }
].

event(search) ->
    Name = util:q(search), 
    case query_names(Name) of
        {ok, _, []} ->
            wf:update(result, #panel { id=result, body=new_node(Name) });
        {ok, _, Results} ->
            wf:update(result, #panel { id=result, body=format_names(Results) })
    end;
event({create,Name}) ->
    {ok, _, [{_Id}]} = db:squery("select nextval('node_id_seq')"),
    Id = binary_to_integer(_Id),
    {ok, 1} = db:equery("INSERT INTO node VALUES ($1)", [Id]),
    {ok, 1} = db:equery("INSERT INTO name (node_id, name) VALUES ($1,$2)", [Id, Name]),
    wf:redirect("node/view/"++_Id).
