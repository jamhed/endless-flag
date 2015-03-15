%% -*- mode: nitrogen -*-
%% vim: ts=4 sw=4 et
-module (node_view).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

main() -> #template { file="./site/templates/bare.html" }.

body() -> 
    {NodeId, _} = string:to_integer(wf:path_info()),
    [
        #link { text = "Добавить", postback=new_dialog },
        #table { id=table, rows=format_rows(NodeId) },
        #panel { id = dynamic }
    ].

format_rows(NodeId) ->
        [ #tablerow {
        cells = [
            #tableheader { text="Дата" },
            #tableheader { text="Название" },
            #tableheader {}
        ] }, format(NodeId)].

format_date(Date) ->
    {Y,M,D} = Date,
    io_lib:format("~B-~2..0B-~2..0B", [Y,M,D]).

format(NodeId) ->
        [#tablerow {
            cells = [
                #tablecell { text = io_lib:format("~B-~2..0B-~2..0B", [Y,M,D]) },
                #tablecell { text = Name },
                #tablecell { body = [ #link { text="Править", postback={edit_dialog,Id} } ] }
            ]
        }
        || {Id,Name,{{Y,M,D},_}} <- query(NodeId)].

query(NodeId) ->
    {ok,_,Rows} = db:equery("SELECT id,name,stamp FROM name WHERE node_id=$1 ORDER BY name", [NodeId]),
    Rows.

dialog_buttons() -> [
    #button { class="btn btn-default", text="Ok", actions=#event{type=click,postback=on_submit} },
    #button { class="btn btn-primary", text="Cancel", data_fields=[{dismiss,modal}] }
].

dialog_buttons(Id) -> [
    #button { class="btn btn-default", text="Удалить", actions=#event{type=click,postback={on_delete,Id}} },
    #button { class="btn btn-primary", text="Сохранить", actions=#event{type=click,postback={on_update,Id}} }
].


dialog_body() -> [
    #datepicker_textbox{ id=date, class="form-control" },
    #fg{ id=name, label = "" }
].
dialog_body(Id) ->  
    {ok, _, [{Name,{Date,_}}]} = db:equery("SELECT name,stamp FROM name WHERE id=$1", [Id]),
    [
        #datepicker_textbox{ id=date, text=format_date(Date), class="form-control" },
        #fg{ id=name, value=Name, label = "" }
    ].

event(new_dialog) ->
    wf:update(dynamic, #dialog{ id=dialog, title="Название", buttons=dialog_buttons(), body=dialog_body() });
event({edit_dialog, Id}) ->
    wf:update(dynamic, #dialog{ id=dialog, title="Название", buttons=dialog_buttons(Id), body=dialog_body(Id) });
event({on_delete, Id}) ->
    {NodeId, _} = string:to_integer(wf:path_info()),
    {ok,1} = db:equery("DELETE FROM name WHERE id=$1 AND node_id=$2", [Id, NodeId]),
    wf:wire(dialog, #dialog_close {}),
    wf:update(table, format_rows(NodeId));
event({on_update, Id}) ->
    {NodeId, _} = string:to_integer(wf:path_info()),
    Date = util:parse_date(wf:q(date)),
    Name = util:q(name),
    {ok,1} = db:equery("UPDATE name SET name=$1, stamp=$2 WHERE id=$3 AND node_id=$4", [Name, {Date,{0,0,0}}, Id, NodeId]),
    wf:wire(dialog, #dialog_close {}),
    wf:update(table, format_rows(NodeId));
event(on_submit) ->
    {NodeId, _} = string:to_integer(wf:path_info()),
    Date = util:parse_date(wf:q(date)),
    Name = util:q(name),
    {ok, 1} = db:equery("INSERT INTO name (node_id,name,stamp) VALUES ($1,$2,$3)", [NodeId, Name, {Date,{0,0,0}}]),
    wf:wire(dialog, #dialog_close {}),
    wf:update(table, format_rows(NodeId));
event(EventInfo) ->
    ?PRINT(EventInfo)
.
